import { FC, PropsWithChildren } from "react";

const Dogs: FC<PropsWithChildren> = ({ children }) => {
  return <div>{children}</div>;
};
