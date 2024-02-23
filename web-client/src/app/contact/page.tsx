import { Center, Container, Flex } from "@mantine/core";

export default function Page() {
  return (
    <Container>
      <h2>お問い合わせ先</h2>
      <Center>
        <p>Instagram: </p>
        <a
          href="https://www.instagram.com/with_bichon/"
          target="_blank"
          rel="noopener noreferrer"
        >
          withビション公式
        </a>
      </Center>
      <Flex justify={"center"} align={"center"}>
        <p>連絡先: </p>
        <p>withbichon@gmail.com</p>
      </Flex>
    </Container>
  );
}
