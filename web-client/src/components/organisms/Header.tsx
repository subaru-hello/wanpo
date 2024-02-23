"use client";
import { Menu, Group, Center, Burger, Container } from "@mantine/core";
import { useDisclosure } from "@mantine/hooks";
// import { IconChevronDown } from "@tabler/icons-react";
import classes from "@/assets/Header.module.css";
import wajiLogo from "@/assets/IMG_7404-modified.ico";
import Image from "next/image";
import Link from "next/link";

const links = [
  {
    link: "/walk-entries",
    label: "散歩日誌一覧",
    // links: [{ link: "", label: "" }],
  },
  //   {
  //     link: "#1",
  //     label: "Learn",
  //     links: [
  //       { link: "/docs", label: "Documentation" },
  //       { link: "/resources", label: "Resources" },
  //       { link: "/community", label: "Community" },
  //       { link: "/blog", label: "Blog" },
  //     ],
  //   },
  //   { link: "/", label: "About" },
  //   { link: "/pricing", label: "Pricing" },
  //   {
  //     link: "#2",
  //     label: "Support",
  //     links: [
  //       { link: "/faq", label: "FAQ" },
  //       { link: "/demo", label: "Book a demo" },
  //       { link: "/forums", label: "Forums" },
  //     ],
  //   },
];

export function HeaderMenu() {
  const [opened, { toggle }] = useDisclosure(false);

  const items = links.map(
    (link: {
      link: string;
      label: string;
      links?: [{ link?: string; label: string }];
    }) => {
      const menuItems = link.links?.map(
        (innerLink) =>
          innerLink?.link && (
            <Menu.Item key={innerLink.link}>{innerLink.label}</Menu.Item>
          )
      );

      //   if (menuItems) {
      return (
        <Menu
          key={link.label}
          trigger="hover"
          transitionProps={{ exitDuration: 0 }}
          withinPortal
        >
          <Menu.Target>
            <Link href={link.link} className={classes.link}>
              <Center>
                <span className={classes.linkLabel}>{link.label}</span>
                {/* <IconChevronDown size="0.9rem" stroke={1.5} /> */}
              </Center>
            </Link>
          </Menu.Target>
          {/* <Menu.Dropdown>{menuItems}</Menu.Dropdown> */}
        </Menu>
      );
      //   }

      //   return (
      //     <a
      //       key={link.label}
      //       href={link.link}
      //       className={classes.link}
      //       onClick={(event) => event.preventDefault()}
      //     >
      //       {link.label}
      //     </a>
      //   );
    }
  );

  return (
    <header className={classes.header}>
      <Container>
        <div className={classes.inner}>
          <Link href="/">
            <Image src={wajiLogo} alt="bichon icon" height={50} width={50} />
          </Link>
          <Group gap={5} visibleFrom="sm">
            {items}
          </Group>
          <Burger opened={opened} onClick={toggle} size="sm" hiddenFrom="sm" />
        </div>
      </Container>
    </header>
  );
}
