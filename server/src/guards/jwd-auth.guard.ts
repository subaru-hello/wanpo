import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { CognitoJwtVerifier } from 'aws-jwt-verify';

@Injectable()
export class JwtAuthGuard implements CanActivate {
  private jwtVerifier = CognitoJwtVerifier.create({
    userPoolId: process.env.COGNITO_USER_POOL_ID,
    tokenUse: 'access',
    clientId: process.env.COGNITO_CLIENT_ID,
    scope: 'aws.cognito.signin.user.admin',
  });
  async canActivate(context: ExecutionContext) {
    const request = context.switchToHttp().getRequest();
    try {
      const result = await this.jwtVerifier.verify(
        request.header('authorization'),
      );
      console.log('jwt verified res', result);
      return !!result;
    } catch (error) {
      console.log('not authed');
      return false;
    }
  }
}
