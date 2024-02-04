import { IsEmail, IsString, Matches, MinLength } from 'class-validator';

export class SignUpRequestDto {
  @IsEmail()
  email: string;

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
