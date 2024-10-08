import { Injectable, UnauthorizedException } from '@nestjs/common';
import {
  AuthenticationDetails,
  CognitoRefreshToken,
  CognitoUser,
  CognitoUserAttribute,
  CognitoUserPool,
  CognitoUserSession,
} from 'amazon-cognito-identity-js';
import {
  VerifyUserAttributeCommand,
  CognitoIdentityProviderClient,
} from '@aws-sdk/client-cognito-identity-provider';
import { ConfigService } from '@nestjs/config';
import { SignUpRequestDto } from './dto/signup-request.dto';
import { fetchUsersFromCognitoPool } from './utils/cognito';
import { AuthenticateRequestDto } from './dto/authenticate-request.dto';
import { VeirfyRequestDto } from './dto/verify-request.dto';
import { ChangePasswordRequestDto } from './dto/change-password-request.dto';
import { ForgotPasswordRequestDto } from './dto/forgot-password-request.dto';
import { jwtDecode } from 'jwt-decode';
import { PrismaService } from '@Src/prisma/prisma.service';
import { DogOwnerService } from '@Src/dog-owner/dog-owners.service';
import {
  AdminDeleteUserCommand,
  AdminUpdateUserAttributesCommand,
  CognitoIdentityProvider,
  AdminUserGlobalSignOutCommand,
} from '@aws-sdk/client-cognito-identity-provider';

@Injectable()
export class AuthService {
  private userPool: CognitoUserPool;

  constructor(
    private configService: ConfigService,
    private prisma: PrismaService,
    private dogOwnerService: DogOwnerService,
  ) {
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
  async confirmRegistration(verifyParam: VeirfyRequestDto) {
    const { email, token } = verifyParam;
    const userData = {
      Username: email,
      Pool: this.userPool,
    };
    console.log('====', email, token);
    const cognitoUser = new CognitoUser(userData);

    return new Promise((resolve, reject) => {
      return cognitoUser.confirmRegistration(
        token.toString(),
        true,
        async function (error, result) {
          if (error) reject(error);
          // 既存のユーザーのcognitosubを更新する
          console.log('======', result);
          resolve(result);
        },
      );
    });
  }

  //TODO:  成功した場合にcognitoのEmail verifiedをYesにする
  async confirmEmailChange(verifyParam: VeirfyRequestDto, accessToken: string) {
    const { email, token } = verifyParam;
    const userData = {
      Username: email,
      Pool: this.userPool,
    };
    console.log('====', email, token, accessToken);
    const client = new CognitoIdentityProviderClient(userData);
    const input = {
      AccessToken: accessToken, // required
      // AccessToken:
      // required
      AttributeName: email, // required
      Code: token, // required
    };
    const command = new VerifyUserAttributeCommand(input);
    console.log('comand====,', command);
    console.log('client====', client);
    const cognitoUser = new CognitoUser(userData);
    // console.log(cognitoUser);
    // const authenticationDetails = new AuthenticationDetails({
    //   Username: email,
    // });
    // console.log(cognitoUser.getUserAttributes);
    // console.log(authenticationDetails);
    // const input = {
    //   UserPoolId: this.userPool.getUserPoolId(),
    //   Username: email,
    //   UserAttributes: [
    //     {
    //       Name: 'email',
    //       Value: email,
    //     },
    //     {
    //       Name: 'email_verified',
    //       Value: 'true',
    //     },
    //   ],
    // };
    // const client = new CognitoIdentityProvider({ region: 'ap-northeast-1' });
    // const command = new AdminUpdateUserAttributesCommand(input);
    try {
      // await client.send(command);
      console.log('after sent');
      // await this.authenticateUser(cognitoUser, authenticationDetails);
      // return new Promise((resolve, reject) => {
      const response = await client.send(command); // console.log(
      console.log('===', response);

      //   //   '=====',
      //   //   new AuthenticationDetails({ Username: email }).getPassword(),
      //   // );
      //   cognitoUser.verifyAttribute('email', token, {
      //     onSuccess: (result) => {
      //       console.log('Email verification successful:', result);
      //       resolve(result);
      //     },
      //     onFailure: (err) => {
      //       console.error('Email verification failed:', err);
      //       reject(err);
      //     },
      //   });
      // });
      // const result = await this.verifyUserAttribute(cognitoUser, token);
      // console.log('Verification process complete:', result);
    } catch (error) {
      console.error('error:', error);
    }

    // return new Promise((resolve, reject) => {
    //   cognitoUser.authenticateUser(authenticationDetails, {
    //     onSuccess: () => {
    //       cognitoUser.verifyAttribute('email', token, {
    //         onSuccess(result) {
    //           console.log('Email verification successful:', result);
    //           resolve(result);
    //         },
    //         onFailure(err) {
    //           console.error('Email verification failed:', err);
    //           reject(err);
    //         },
    //       });
    //     },
    //     onFailure: (err) => {
    //       reject(err);
    //     },
    //   });
    // });
  }

  authenticateUser(cognitoUser, authenticationDetails) {
    return new Promise((resolve, reject) => {
      cognitoUser.authenticateUser(authenticationDetails, {
        onSuccess: resolve,
        onFailure: reject,
      });
    });
  }

  async signOut(email: string) {
    const adminUserGlobalSignOutCommandInput = {
      UserPoolId: this.userPool.getUserPoolId(),
      Username: email,
    };
    const client = new CognitoIdentityProvider({ region: 'ap-northeast-1' });
    const command = new AdminUserGlobalSignOutCommand(
      adminUserGlobalSignOutCommandInput,
    );
    try {
      const adminUserGlobalSignOutCommandResults = await client.send(command);
      console.log(
        'adminUserGlobalSignOutCommandResults',
        adminUserGlobalSignOutCommandResults,
      );
      console.log('User signed out successfully');
      return true;
    } catch (err) {
      console.error('Sign out failed:', err);
      throw err;
    }
  }

  verifyUserAttribute(cognitoUser, token) {
    return new Promise((resolve, reject) => {
      cognitoUser.verifyAttribute('email', token, {
        onSuccess: (result) => {
          console.log('Email verification successful:', result);
          resolve(result);
        },
        onFailure: (err) => {
          console.error('Email verification failed:', err);
          reject(err);
        },
      });
    });
  }

  // 認証に成功したら、JWTを含むjsonを返す
  async authenticate(user: AuthenticateRequestDto) {
    const { email, password } = user;
    try {
      const authenticationDetails = new AuthenticationDetails({
        Username: email,
        Password: password,
      });

      const userData = {
        Username: email,
        Pool: this.userPool,
      };
      const newUser = new CognitoUser(userData);
      try {
        const result = await AuthService.authenticateUser(
          newUser,
          authenticationDetails,
        );
        const jwtToken = result.getAccessToken().getJwtToken();
        const refreshToken = result.getRefreshToken().getToken();
        const decodedJwtToken = jwtDecode(jwtToken); // Ensure jwtDecode is defined or imported
        const cognitoSub = decodedJwtToken.sub;

        console.log('end');
        return {
          jwtToken,
          refreshToken: refreshToken,
          cognitoSub,
        };
        // 以降の処理...
      } catch (err) {
        console.error('Authentication error:', err);
        // エラー処理...
      }
      console.log('aaaa');
      // セッション管理に必要な情報を抽出
    } catch (err) {
      console.error('Authentication error:', err);
      throw err;
    }
  }

  private static authenticateUser(
    newUser: CognitoUser,
    authenticationDetails: AuthenticationDetails,
  ): Promise<CognitoUserSession> {
    return new Promise((resolve, reject) => {
      newUser.authenticateUser(authenticationDetails, {
        onSuccess: (result) => resolve(result),
        onFailure: (err) => {
          console.log('Authentication failed', err);
          reject(err);
        },
        newPasswordRequired: function (userAttributes, requiredAttributes) {
          console.log('New password required');
          // newPasswordRequiredに対する処理...
        },
      });
    });
  }

  async refreshAccessToken({
    refreshToken,
    cognitoSub,
  }: {
    refreshToken: string;
    cognitoSub: string;
  }) {
    const dogOwner = await this.prisma.dogOwner.findFirst({
      select: { email: true },
      where: {
        cognitoSub: cognitoSub,
      },
    });
    console.log('dogOwner', dogOwner);
    const userData = {
      Username: dogOwner.email,
      Pool: this.userPool,
    };

    const cognitoUser = new CognitoUser(userData);

    return new Promise((resolve, reject) => {
      cognitoUser.refreshSession(
        new CognitoRefreshToken({ RefreshToken: refreshToken }),
        (err, session) => {
          if (err) {
            console.error('Refresh token error:', err);
            reject(err);
          } else {
            const newJwtToken = session.getAccessToken().getJwtToken();
            console.log('Refreshed access token:', newJwtToken);
            resolve(newJwtToken);
          }
        },
      );
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
  loggedIn() {
    return new Promise((resolve, reject) => {
      const cognitoUser = this.userPool.getCurrentUser();
      console.log('Current user:', cognitoUser);

      if (!cognitoUser) {
        console.log('No user logged in.');
        resolve(false); // No user is logged in
      } else {
        cognitoUser.getSession((err, session) => {
          if (err) {
            console.log('Failed to get session, login required:', err);
            resolve(false);
          } else {
            console.log('Session valid:', session.isValid());
            // Check if session is valid
            if (session.isValid()) {
              cognitoUser.getUserAttributes((err, attributes) => {
                if (err) {
                  console.log('Failed to fetch user attributes:', err);
                  reject(err); // Error fetching user attributes
                } else {
                  console.log('User attributes:', attributes);
                  resolve(true); // Session is valid and user attributes fetched
                }
              });
            } else {
              resolve(false); // Session is not valid
            }
          }
        });
      }
    });
  }

  async deleteCognitoUser({ email }: { email: string }) {
    // cognitoUserPoolからユーザーを削除
    const adminDeleteUserCommandInput = {
      UserPoolId: this.userPool.getUserPoolId(),
      Username: email,
    };
    const client = new CognitoIdentityProvider({ region: 'ap-northeast-1' });
    const command = new AdminDeleteUserCommand(adminDeleteUserCommandInput);
    try {
      const adminDeleteUserCommandResults = await client.send(command);
      console.log(
        'adminDeleteUserCommandResults',
        adminDeleteUserCommandResults,
      );
      console.log('User deleted successfully');
      return true;
    } catch (err) {
      console.error('Deletion failed:', err);
      throw err;
    }
  }

  // メールをおくる関数を作成
  // async sendCode({email, newEmail}: {}){

  // }

  // https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/client/cognito-identity-provider/command/AdminUpdateUserAttributesCommand/
  async changeCognitoEmail({
    email,
    newEmail,
  }: {
    email: string;
    newEmail: string;
  }) {
    // cognitoUserPoolいる
    const input = {
      UserPoolId: this.userPool.getUserPoolId(),
      Username: email,
      UserAttributes: [
        {
          Name: 'email',
          Value: newEmail,
        },
        {
          Name: 'name',
          Value: newEmail,
        },
        {
          Name: 'email_verified',
          Value: 'false',
        },
      ],
    };

    const client = new CognitoIdentityProvider({ region: 'ap-northeast-1' });
    const command = new AdminUpdateUserAttributesCommand(input);
    try {
      const res = await client.send(command);
      console.log('update succeeded', res);
    } catch (error) {
      console.log('update failed');
    }
  }
}
