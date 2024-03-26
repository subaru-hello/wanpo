import { Group, Pagination } from "@mantine/core";
import { FC } from "react";

type Props = {
  total: number;
  initialPage: number;
};
export const MPagination: FC<Props> = (props) => {
  const { total, initialPage } = props;
  return (
    <Pagination.Root total={total} defaultValue={initialPage}>
      <Group gap={5} justify="center">
        <Pagination.First />
        <Pagination.Previous />
        <Pagination.Items />
        <Pagination.Next />
        <Pagination.Last />
      </Group>
    </Pagination.Root>
  );
};
