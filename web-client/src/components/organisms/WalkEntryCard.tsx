"use client";
import { Card, Image, Text, Button, Group } from "@mantine/core";
import { FC } from "react";
// import { CoreButton } from "../atoms/Button";

type Props = {
  src: string;
  height: number;
  alt: string;
  title?: string;
  date: Date;
  createdAt?: Date;
  duaration?: number;
  stepCount?: number;
  summaryImagePath?: string;
};
export const WalkEntryCard: FC<Props> = (props) => {
  const {
    alt,
    src,
    height,
    title,
    date,
    createdAt,
    duaration,
    stepCount,
    summaryImagePath,
  } = props;
  // const onClick = () => console.log("=====clicked===");

  return (
    <Card shadow="sm" padding="lg" radius="md" withBorder>
      <Card.Section>
        <Image src={src} height={height} alt={alt} />
      </Card.Section>

      <Group justify="space-between" mt="md" mb="xs">
        <Text fw={500}>{title}</Text>
        <Text fw={500}>{new Date(date).toDateString()}</Text>
        {/* <Badge color="pink">On Sale</Badge> */}
      </Group>

      <Text size="sm" c="dimmed">
        {title}。めっちゃ楽しかった！
      </Text>

      <Group justify="space-between" mt="md" mb="xs">
        <Text fw={500}>歩数</Text>
        {/* <Badge color="pink">On Sale</Badge> */}
      </Group>
      <Text size="sm" c="dimmed">
        {stepCount}歩
      </Text>
      {/* <CoreButton
        color="blue"
        disabled={false}
        loading={false}
        onClick={onClick}
        fullWidth={true}
        mt="md"
        radius="md"
        text="詳細"
      /> */}
    </Card>
  );
};
1;
