import { Request } from 'express';

export function extractValueFromCookie(
  cookie: string,
  key: string,
): string | null {
  if (!cookie) return null;

  const cookiesArray = cookie.split(';');
  const valueOfCookie = cookiesArray.find((cookie) =>
    cookie.trim().startsWith(key),
  );

  if (!valueOfCookie) return null;
  console.log('^^^^^', valueOfCookie);
  return getValueFromCookie(valueOfCookie);
}

function getValueFromCookie(cookie: string): string | null {
  if (!cookie) return null;
  return cookie.split('=')[1];
}

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
  return getValueFromCookie(cognitoSubCookie);
}
