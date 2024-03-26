import { FooterCentered } from "@/components/organisms/Footer";
import { HeroContentLeft } from "@/components/organisms/HeroWallPaper";
import Link from "next/link";
import { cookies } from "next/headers";
import { setCookie } from "./setCookie";

export async function login(email: string, password: string): Promise<any> {
  "use server";
  const apiUrl = process.env.API_URL ?? "";
  console.log("=====loginurl====", apiUrl);
  const res = await fetch(`${apiUrl}/auth/login`, {
    method: "POST", // HTTPメソッドをPOSTに設定
    headers: {
      "Content-Type": "application/json", // コンテンツタイプをJSONに設定
    },
    body: JSON.stringify({
      email: email,
      password: password,
    }), // リクエストボディにemailとpasswordを含める
    credentials: "include", // クッキーを含めるための設定
  });

  if (!res.ok) {
    // レスポンスのステータスが成功を示していない場合
    console.log("ログイン情報が違います", res.status);
    // throw new Error(`Error: ${res.status}`); // エラーをスロー
  }
  console.log("======", res.headers);

  const data = res.json(); // レスポンスボディをJSONとしてパース
  console.log("===data===", res.headers.getSetCookie());
  const returnedCookie = res.headers.getSetCookie();
  setCookie(returnedCookie);
  return data;
}

export async function isLoggedIn(): Promise<any> {
  "use server";
  const apiUrl = process.env.API_URL ?? "";
  console.log("=====loginurl====", apiUrl);
  const res = await fetch(`${apiUrl}/auth/isLoggedIn`, {
    method: "GET",
  });
  console.log("isLoggedIn?", res.ok);
}

export default async function Home() {
  (async () => {
    "use sever";
    cookies().set("test", "aaa");
  })();
  await login("octosubaru0926+3@gmail.com", "qwe123sdf!");
  await isLoggedIn();
  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
      {/* header */}
      {/* sWaiper section */}
      <HeroContentLeft />
    </main>
  );
}
