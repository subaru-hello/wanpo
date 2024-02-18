import { Overlay, Container, Title, Button, Text } from "@mantine/core";
import classes from "@/app/HeroContent.module.css";
import Link from "next/link";

export function HeroContentLeft() {
  return (
    <div className={classes.hero}>
      <Overlay
        gradient="linear-gradient(180deg, rgba(0, 0, 0, 0.25) 0%, rgba(0, 0, 0, .65) 40%)"
        opacity={1}
        zIndex={0}
      />
      <Container className={classes.container} size="md">
        <Title className={classes.title}>with ビション</Title>
        <Text className={classes.description} size="xl" mt="xl">
          ビションフリーゼと楽しく暮らす毎日を共有
        </Text>
        <Link
          href="/walk-entries"
          className={classes.control}
          style={{ backgroundColor: "white" }}
        >
          散歩記録を見る
        </Link>
      </Container>
    </div>
  );
}
