import {
  Body,
  Controller,
  Post,
  HttpCode,
  HttpStatus,
  BadRequestException,
  Get,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { SignUpRequestDto } from './dto/signup-request.dto';
import { AuthenticateRequestDto } from './dto/authenticate-request.dto';
import { VeirfyRequestDto } from './dto/verify-request.dto';
import { ForgotPasswordRequestDto } from './dto/forgot-password-request.dto';
import { ChangePasswordRequestDto } from './dto/change-password-request.dto';

@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @HttpCode(HttpStatus.OK)
  @Post('signUp')
  signIn(@Body() params: SignUpRequestDto) {
    return this.authService.signUp(params);
  }
  @Post('verify')
  verify(@Body() params: VeirfyRequestDto) {
    return this.authService.verifyCode(params);
  }
  @Get('isLoggedIn')
  isLoggedIn() {
    return this.authService.loggedIn();
  }
  @Post('changePassword')
  changePassword(@Body() params: ChangePasswordRequestDto) {
    return this.authService.changePassword(params);
  }
  @Post('forgotPassword')
  forgotPassword(@Body() params: ForgotPasswordRequestDto) {
    return this.authService.forgotPassword(params);
  }
  @Post('resetPassword')
  resetPassword(@Body() params: ForgotPasswordRequestDto) {
    return this.authService.resetPassword(params);
  }
  @Post('authenticate')
  async authenticate(@Body() authenticateRequest: AuthenticateRequestDto) {
    console.log('–––––');
    try {
      return await this.authService.authenticate(authenticateRequest);
    } catch (e) {
      throw new BadRequestException(e.message);
    }
  }
}
