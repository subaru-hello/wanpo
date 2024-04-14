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

  // JWTとリクエストCookieに含まれるjwtTokenが一致していないとエンドポイントを叩けない
  async canActivate(context: ExecutionContext) {
    const request = context.switchToHttp().getRequest();
    console.log('====request===', request.cookies);
    const jwtToken = request.cookies?.jwtToken;
    console.log('Authorization:', request.headers.authorization);
    console.log('JwtToken:', request.cookies?.jwtToken);
    // const token = request.cookies['jwtToken']; // Cookieからトークンを取得
    // if (!token) return false; // トークンがなければアクセス拒否
    try {
      const result = await this.jwtVerifier.verify(jwtToken);
      console.log('jwt verified res', result);
      return !!result;
    } catch (error) {
      console.log('not authed');
      return false;
    }
  }
}
