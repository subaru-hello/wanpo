// Import styles of packages that you've installed.
// All packages except `@mantine/hooks` require styles imports
import "@mantine/core/styles.css";
import { Analytics } from "@vercel/analytics/react";
import { ColorSchemeScript, MantineProvider } from "@mantine/core";
import { FooterCentered } from "@/components/organisms/Footer";
import { HeaderMenu } from "@/components/organisms/Header";

export const metadata = {
  title: "with ビション",
  description: "ビションフリーゼと暮らす毎日を彩る情報を共有。",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="ja">
      <head>
        <ColorSchemeScript />
      </head>
      <body>
        <MantineProvider>
          <HeaderMenu />
          {children}
          <FooterCentered />
        </MantineProvider>
        <Analytics />
      </body>
    </html>
  );
}
