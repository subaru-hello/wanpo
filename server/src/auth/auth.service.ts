import { Injectable, UnauthorizedException } from '@nestjs/common';
import {
  AuthenticationDetails,
  CognitoUser,
  CognitoUserAttribute,
  CognitoUserPool,
} from 'amazon-cognito-identity-js';
import { ConfigService } from '@nestjs/config';
import { SignUpRequestDto } from './dto/signup-request.dto';
import { fetchUsersFromCognitoPool } from './utils/cognito';
import { AuthenticateRequestDto } from './dto/authenticate-request.dto';
import { VeirfyRequestDto } from './dto/verify-request.dto';
import { ChangePasswordRequestDto } from './dto/change-password-request.dto';
import { ForgotPasswordRequestDto } from './dto/forgot-password-request.dto';

@Injectable()
export class AuthService {
  private userPool: CognitoUserPool;

  constructor(private configService: ConfigService) {
    this.userPool = new CognitoUserPool({
      UserPoolId: this.configService.get<string>('COGNITO_USER_POOL_ID'),
      ClientId: this.configService.get<string>('COGNITO_CLIENT_ID'),
    });
  }

  /**
   * 登録に成功したらverification codeを登録されたEmailへ送信する
   * @param authRegisterRequest
   * @returns OK | Error
   */
  async signUp(authRegisterRequest: SignUpRequestDto) {
    const { email, password } = authRegisterRequest;
    // メールアドレスの重複がないかチェックする
    const existedUser = await fetchUsersFromCognitoPool(email);
    if (existedUser.length > 0) {
      console.warn('dupulicate mail address. use other email.');
      throw new UnauthorizedException({
        objectOrError: 'dupulicate mail address. use other email.',
      });
    }
    return new Promise((resolve, reject) => {
      return this.userPool.signUp(
        email,
        password,
        [new CognitoUserAttribute({ Name: 'name', Value: email })],
        null,
        (err, result) => {
          if (!result) {
            reject(err);
          } else {
            resolve(result.user);
          }
        },
      );
    });
  }

  // 成功した場合にcognitoのEmail verifiedをYesにする
  async verifyCode(verifyParam: VeirfyRequestDto) {
    const { email, token } = verifyParam;
    const userData = {
      Username: email,
      Pool: this.userPool,
    };
    const cognitoUser = new CognitoUser(userData);
    return new Promise((resolve, reject) => {
      return cognitoUser.confirmRegistration(
        token.toString(),
        true,
        function (error, result) {
          if (error) reject(error);
          resolve(result);
        },
      );
    });
  }

  // 認証に成功したら、JWTを含むjsonが返る
  async authenticate(user: AuthenticateRequestDto) {
    const { email, password } = user;
    const authenticationDetails = new AuthenticationDetails({
      Username: email,
      Password: password,
    });
    const userData = {
      Username: email,
      Pool: this.userPool,
    };
    const newUser = new CognitoUser(userData);
    return new Promise((resolve, reject) => {
      return newUser.authenticateUser(authenticationDetails, {
        // JWTとpayloadのみクライアントに返却
        // JWTはクライアントのCookieにHttpOnlyで保存する
        onSuccess: (result) => {
          resolve(result.getAccessToken());
        },
        onFailure: (err) => {
          reject(err);
        },
        newPasswordRequired: function (userAttributes, requireAttributes) {
          var attributesData = {
            name: email,
          };
          newUser.completeNewPasswordChallenge(
            'Password1',
            attributesData,
            this,
          );
        },
      });
    });
  }

  // パスワードを変更
  async changePassword(user: ChangePasswordRequestDto) {
    const { email, old_password, password } = user;
    const userData = {
      Username: email,
      Pool: this.userPool,
    };
    const cognitoUser = new CognitoUser(userData);
    const authenticationDetails = new AuthenticationDetails({
      Username: email,
      Password: old_password,
    });
    return new Promise((resolve, reject) => {
      cognitoUser.authenticateUser(authenticationDetails, {
        onSuccess: () => {
          cognitoUser.changePassword(
            old_password,
            password,
            function (error, result) {
              if (error) reject(error);
              resolve(result);
            },
          );
        },
        onFailure: (err) => {
          reject(err);
        },
      });
    });
  }

  // 成功時にEmailへ向けてverification codeを送信する
  async forgotPassword(user: ForgotPasswordRequestDto) {
    const { email } = user;
    const userData = {
      Username: email,
      Pool: this.userPool,
    };
    const cognitoUser = new CognitoUser(userData);
    return new Promise((resolve, reject) => {
      cognitoUser.forgotPassword({
        onSuccess: (result) => {
          resolve(result);
        },
        onFailure: (err) => {
          reject(err);
        },
      });
    });
  }

  // パスワードをリセットする
  async resetPassword(user: ForgotPasswordRequestDto) {
    const { email, verifyCode, new_password } = user;
    const userData = {
      Username: email,
      Pool: this.userPool,
    };
    const cognitoUser = new CognitoUser(userData);
    return new Promise((resolve, reject) => {
      cognitoUser.confirmPassword(verifyCode.toString(), new_password, {
        onSuccess: (result) => {
          resolve(result);
        },
        onFailure: (err) => {
          reject(err);
        },
      });
    });
  }
  //今セッションを持っているユーザーがログイン中か
  async loggedIn() {
    var cognitoUser = this.userPool.getCurrentUser();
    if (cognitoUser) {
      cognitoUser.getSession(function (err, session) {
        if (err) {
          console.log('required to login');
          return false;
        }
        console.log(session);
        cognitoUser.getUserAttributes(function (err, attributes) {
          if (err) {
            return false;
          } else {
            console.log(attributes);
          }
        });
      });
      return true;
    } else {
      return false;
    }
  }
}
