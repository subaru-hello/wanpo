import { IsString, Matches, MinLength } from 'class-validator';

export class ForgotPasswordRequestDto {
  email: string;
  verifyCode: string;
  @IsString()
  @MinLength(8)
  @Matches(/(?=.*[0-9])/, {
    message: 'Password must contain at least one number.',
  })
  @Matches(/(?=.*[!@#$%^&*])/, {
    message: 'Password must contain at least one special character.',
  })
  new_password: string;
}
