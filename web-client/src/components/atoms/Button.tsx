import { Button } from "@mantine/core";
import { FC, ReactNode } from "react";

type ButtonProps = {
  onClick?: () => void;
  disabled: boolean;
  loading: boolean;
  text: string;
  [key: string]: any;
};

export const CoreButton: FC<ButtonProps> = (props) => {
  const { onClick, text, disabled, loading, ...restProps } = props;
  if (loading) {
    return <></>;
  }
  return (
    <Button onClick={onClick} disabled={disabled} {...restProps}>
      {text}
    </Button>
  );
};
