import { cookies } from "next/headers";
type CookieOptions = {
  [key: string]: string | boolean;
};

export async function setCookie(returnedCookie: string[]) {
  "use server";
  const cookieStore = cookies();
  returnedCookie.forEach((cookieHeader) => {
    const [cookieNameValue, ...options] = cookieHeader.split("; ");
    const [name, value] = cookieNameValue.split("=");
    const optionsObject = options.reduce<CookieOptions>((acc, option) => {
      const [optionKey, optionValue] = option.split("=");
      const camelCaseKey = optionKey.replace(/-\w/g, (match) =>
        match.charAt(1).toUpperCase()
      );
      acc[camelCaseKey] = optionValue ? optionValue : true;
      return acc;
    }, {});
    console.log("==balues==", name, value, optionsObject);
    cookieStore.set(name, value, optionsObject);
  });
  console.log("=======", returnedCookie, "====afaf=", cookieStore.getAll());
}
// Iterate over each Set-Cookie header value and set the cookie
