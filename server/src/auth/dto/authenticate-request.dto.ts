import { IsEmail } from 'class-validator';

export class AuthenticateRequestDto {
  @IsEmail()
  email: string;
  password: string;
}
