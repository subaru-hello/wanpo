// Import styles of packages that you've installed.
// All packages except `@mantine/hooks` require styles imports
import "@mantine/core/styles.css";
import { Analytics } from "@vercel/analytics/react";
import { ColorSchemeScript, MantineProvider } from "@mantine/core";

export const metadata = {
  title: "with ビション.",
  description: "ビションと暮らす毎日を彩る情報を共有。",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <head>
        <ColorSchemeScript />
      </head>
      <body>
        <MantineProvider>{children}</MantineProvider>
        <Analytics />
      </body>
    </html>
  );
}
