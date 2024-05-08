import {
  Body,
  Controller,
  Post,
  HttpCode,
  HttpStatus,
  BadRequestException,
  Get,
  Res,
  Req,
  Delete,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { SignUpRequestDto } from './dto/signup-request.dto';
import { AuthenticateRequestDto } from './dto/authenticate-request.dto';
import { VeirfyRequestDto } from './dto/verify-request.dto';
import { ForgotPasswordRequestDto } from './dto/forgot-password-request.dto';
import { ChangePasswordRequestDto } from './dto/change-password-request.dto';
import { Response, Request } from 'express';
import { DogOwnerService } from '@Src/dog-owner/dog-owners.service';
import { extractValueFromCookie } from './utils/httpUtils';
import { COGNITO_KEY, REFRESH_TOKEN_KEY } from 'constants/cookies';
import { fetchUsersFromCognitoPool } from './utils/cognito';
import { ERROR_CODES } from 'constants/errorCodes';
import { ChangeEmailDto } from './dto/change-email.dto';
import { PrismaService } from '@Src/prisma/prisma.service';

@Controller('auth')
export class AuthController {
  constructor(
    private authService: AuthService,
    private dogOwnerService: DogOwnerService,
    private prisma: PrismaService,
  ) {}

  @HttpCode(HttpStatus.OK)
  @Post('sign-up')
  async signUp(@Body() params: SignUpRequestDto, @Res() res: Response) {
    // created_atから10分間経っても認証されていないユーザーは削除
    try {
      await this.authService.signUp(params);

      await this.dogOwnerService.registerOwner({ email: params.email });
    } catch (error) {
      console.log(ERROR_CODES.SIGN_UP_ERROR);
      throw new Error(error);
    }
    // 「認証コードを送りましたので、メールをご確認ください」を送る
    return res.sendStatus(HttpStatus.OK);
  }

  @Post('verify')
  async verify(@Body() params: VeirfyRequestDto) {
    // dogOwnerからemailが一致かつcreated_atが現在時刻より10分以前のユーザーをfindOneする
    // 10分経って未認証のdogOwnerは削除する
    const targetOwner = await this.dogOwnerService.findOne(params);
    if (!targetOwner) {
      console.log(ERROR_CODES.USER_NOT_FOUND_ERROR);
      return ERROR_CODES.USER_NOT_FOUND_ERROR;
    }
    const isExpiredOwner = await this.dogOwnerService.findUnVerifiedOwner({
      id: targetOwner.id,
    });

    // 見つかった場合、該当dogOwnerのcognitoSubでuserPoolを検索し、削除する
    if (isExpiredOwner) {
      console.log('isEx', isExpiredOwner);
      await this.deleteCognitoUser(params);
      await this.dogOwnerService.unRegisterOwner(params);
      return ERROR_CODES.EXPIRED_USER_ERROR;
    }
    console.log(targetOwner);
    const isVerifySucceeded =
      await this.authService.confirmRegistration(params);
    console.log('isVeryfySucceeded', isVerifySucceeded);
    // dogOwnerテーブルからも削除する(unregisteredAtを現在時刻にする)
    // 認証期限が過ぎています。さいど作成しなおしてくださいという旨のメールを返す
    // 見つからなかった場合、this.authService.confirmRegistration(params)を返す
    if (isVerifySucceeded === 'SUCCESS') {
      const user = await fetchUsersFromCognitoPool(params.email);
      const cognitoSub = user[0]['Username'];
      console.log(cognitoSub);
      await this.dogOwnerService.updateOwnerInfo({
        email: params.email,
        cognitoSub: cognitoSub,
      });
      return true;
    }
    return false;
  }

  @Get('is-logged-in')
  async isLoggedIn(@Res() res: Response) {
    const isLoggedIn = await this.authService.loggedIn();
    return res.status(HttpStatus.OK).send(isLoggedIn);
  }

  @Post('change-password')
  changePassword(@Body() params: ChangePasswordRequestDto) {
    return this.authService.changePassword(params);
  }

  @Post('forgot-password')
  forgotPassword(@Body() params: ForgotPasswordRequestDto) {
    return this.authService.forgotPassword(params);
  }

  @Post('reset-password')
  resetPassword(@Body() params: ForgotPasswordRequestDto) {
    return this.authService.resetPassword(params);
  }

  @Delete('delete')
  async deleteCognitoUser(@Body() params: { email: string }) {
    try {
      await this.authService.deleteCognitoUser(params);
      return true;
    } catch (error) {
      console.log('cognito user deletion failed', error);
      throw new Error(error);
    }
  }

  @Get('refresh-access-token')
  async refreshAccessToken(@Req() req: Request, @Res() res: Response) {
    console.log(req.headers.cookie);
    const cookie = req.headers.cookie;
    const cognitoSub = extractValueFromCookie(cookie, COGNITO_KEY);
    const refreshToken = extractValueFromCookie(cookie, REFRESH_TOKEN_KEY);
    if (!cognitoSub || !refreshToken) {
      return res
        .status(HttpStatus.UNAUTHORIZED)
        .send(ERROR_CODES.LOGIN_REQUIRED);
    }
    console.log('cognitoSub', cognitoSub);
    console.log('refreshToken', refreshToken);
    const accessToken = await this.authService.refreshAccessToken({
      refreshToken,
      cognitoSub,
    });
    res.cookie('jwtToken', accessToken);
    return res.status(HttpStatus.OK).send();
  }

  @Post('login')
  // @UseGuards(JwtAuthGuard)
  async login(
    @Req() req: Request,
    @Res() response: Response,
    @Body() authenticateRequest: AuthenticateRequestDto,
  ) {
    console.log('–––––', req.headers);
    console.log('–––––', authenticateRequest);
    console.log('–––––', req.headers.cookie);
    try {
      const { jwtToken, refreshToken, cognitoSub } =
        await this.authService.authenticate(authenticateRequest);
      response.cookie('jwtToken', jwtToken);
      response.cookie('cognitoSub', cognitoSub);
      response.cookie('refreshToken', refreshToken);
      // 他の情報をCookieにセットする場合
      // response.cookie('cognitoSub', cognitoSub, {
      //   httpOnly: true,
      //   secure: true, // 本番環境でHTTPSを使用している場合
      //   path: '/',
      //   maxAge: 3600000, // 有効期間（例: 1時間）
      // });
      console.log('response', response.req.cookies);
      return response.status(HttpStatus.OK).send();
      // .json({
      //   jwtToken: jwtToken,
      //   refreshToken: refreshToken,
      //   cognitoSub: cognitoSub,
      // })
    } catch (e) {
      throw new BadRequestException(e.message);
    }
  }

  @Post('change-email')
  async changeEmail(
    @Res() response: Response,
    @Body() changeEmailRequest: ChangeEmailDto,
  ) {
    const existedUser = await fetchUsersFromCognitoPool(
      changeEmailRequest.newEmail,
    );
    if (existedUser.length) {
      return response
        .status(HttpStatus.OK)
        .send('ご使用になれないメールアドレスです');
    }
    // verify code
    // if success
    try {
      const result =
        await this.dogOwnerService.updateOwnerInfo(changeEmailRequest);

      // 該当オーナーが存在しない場合は、メールを更新させない
      if (result === 'NO_OWNER_FOUND') {
        return response.status(HttpStatus.NOT_FOUND).send(result);
      }
      await this.authService.changeCognitoEmail(changeEmailRequest);
      return response.status(HttpStatus.OK).send(result);
    } catch (error) {
      console.log('error', error);
      throw new Error(error);
    }
  }

  @Post('verify-email')
  async veryfyEmail(@Body() params: VeirfyRequestDto) {
    console.log('^^');
    try {
      const isVerifySucceeded =
        await this.authService.confirmEmailChange(params);
      console.log('isSucceeded', isVerifySucceeded);
    } catch (error) {
      console.log('error', error);
    }
  }
}
