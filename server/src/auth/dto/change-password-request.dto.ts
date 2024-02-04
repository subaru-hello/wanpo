import { IsEmail, IsString, Matches, MinLength } from 'class-validator';

export class ChangePasswordRequestDto {
  @IsEmail()
  email: string;
  old_password: string;
  @IsString()
  @MinLength(8)
  @Matches(/(?=.*[0-9])/, {
    message: 'Password must contain at least one number.',
  })
  @Matches(/(?=.*[!@#$%^&*])/, {
    message: 'Password must contain at least one special character.',
  })
  password: string;
}
