import { Request } from 'express';

export function getCognitoSubFromCookie(req: Request): string | null {
  const cookies = req.headers.cookie;
  console.log('---cookie---', cookies);
  if (!cookies) return null;

  // Cookie文字列をセミコロンで分割して、それぞれのCookieを取得します。
  const cookiesArray = cookies.split(';');

  // "cognito-sub"キーに一致するCookieを検索します。
  const cognitoSubCookie = cookiesArray.find((cookie) =>
    cookie.trim().startsWith('cognito-sub='),
  );

  if (!cognitoSubCookie) return null;

  // "cognito-sub"キーの値部分だけを抽出します。
  const cognitoSubValue = cognitoSubCookie.split('=')[1];
  return cognitoSubValue;
}
