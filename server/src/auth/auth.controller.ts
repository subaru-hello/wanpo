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
  UseGuards,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { SignUpRequestDto } from './dto/signup-request.dto';
import { AuthenticateRequestDto } from './dto/authenticate-request.dto';
import { VeirfyRequestDto } from './dto/verify-request.dto';
import { ForgotPasswordRequestDto } from './dto/forgot-password-request.dto';
import { ChangePasswordRequestDto } from './dto/change-password-request.dto';
import { Response } from 'express';
import { DogOwnerService } from '@Src/dog-owners/dog-owners.service';
import { JwtAuthGuard } from '@Src/guards/jwd-auth.guard';

@Controller('auth')
export class AuthController {
  constructor(
    private authService: AuthService,
    private dogOwnerService: DogOwnerService,
  ) {}

  @HttpCode(HttpStatus.OK)
  @Post('sign-up')
  async signUp(@Body() params: SignUpRequestDto, @Res() res: Response) {
    // created_atから10分間経っても認証されていないユーザーは削除
    try {
      await this.authService.signUp(params);

      await this.dogOwnerService.registerOwner({ email: params.email });
    } catch (error) {
      console.log('signUpError');
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

    const isExpiredOwner = await this.dogOwnerService.findUnVerifiedOwner({
      id: targetOwner.id,
    });
    // 見つかった場合、該当dogOwnerのuserSubでuserPoolを検索し、削除する
    if (isExpiredOwner) {
      await this.deleteCognitoUser(params);
      await this.dogOwnerService.unRegisterOwner(params);
      return 'EXPIRED_USER_ERROR';
    }
    // dogOwnerテーブルからも削除する(unregisteredAtを現在時刻にする)
    // 認証期限が過ぎています。さいど作成しなおしてくださいという旨のメールを返す
    // 見つからなかった場合、this.authService.verifyCode(params)を返す
    return this.authService.verifyCode(params);
  }

  @Get('is-logged-in')
  isLoggedIn() {
    return this.authService.loggedIn();
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

  @Post('login')
  // @UseGuards(JwtAuthGuard)
  async login(
    @Req() req: Request,
    @Res() response: Response,
    @Body() authenticateRequest: AuthenticateRequestDto,
  ) {
    console.log('–––––', req.headers);
    try {
      const { jwtToken, refreshToken, userSub } =
        await this.authService.authenticate(authenticateRequest);
      response.cookie('jwtToken', jwtToken);
      response.cookie('userSub', userSub);
      response.cookie('refreshToken', refreshToken);
      // 他の情報をCookieにセットする場合
      // response.cookie('userSub', userSub, {
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
      //   userSub: userSub,
      // })
    } catch (e) {
      throw new BadRequestException(e.message);
    }
  }
}
