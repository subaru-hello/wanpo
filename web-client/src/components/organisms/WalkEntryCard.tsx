"use client";
import { Card, Image, Text, Button, Group } from "@mantine/core";
import { FC } from "react";
import { CoreButton } from "../atoms/Button";

type Props = {
  src: string;
  height: number;
  alt: string;
};
export const WalkEntryCard: FC<Props> = (props) => {
  const { alt, src, height } = props;
  const onClick = () => console.log("=====clicked===");

  return (
    <Card shadow="sm" padding="lg" radius="md" withBorder>
      <Card.Section>
        <Image src={src} height={height} alt={alt} />
      </Card.Section>

      <Group justify="space-between" mt="md" mb="xs">
        <Text fw={500}>散歩の記録</Text>
        {/* <Badge color="pink">On Sale</Badge> */}
      </Group>

      <Text size="sm" c="dimmed">
        今日はここに行ってきたよ
      </Text>

      <CoreButton
        color="blue"
        disabled={false}
        loading={false}
        onClick={onClick}
        fullWidth={true}
        mt="md"
        radius="md"
        text="クリックしてみて"
      />
    </Card>
  );
};
1;
