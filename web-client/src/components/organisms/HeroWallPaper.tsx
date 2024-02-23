import { Overlay, Container, Title, Button, Text } from "@mantine/core";
import Link from "next/link";
import InstagramCaroucel from "./InstagramCarousel";

export function HeroContentLeft() {
  return (
    <>
      <Container>
        <Title>with ビション</Title>
        <Text size="xl" mt="xl">
          ビションフリーゼと楽しく暮らす毎日を共有
        </Text>
        <Link href="/walk-entries" style={{ backgroundColor: "white" }}>
          みんなの散歩日誌を見る
        </Link>
      </Container>
      <Container>
        <InstagramCaroucel />
      </Container>
    </>
  );
}
