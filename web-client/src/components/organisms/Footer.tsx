"use client";
import { Anchor, Group, ActionIcon, rem } from "@mantine/core";
import { IconBrandInstagram } from "@tabler/icons-react";
import classes from "@/app/FooterCentered.module.css";
import Link from "next/link";
import Image from "next/image";
const links = [
  { link: "/contact", label: "お問い合わせ" },
  { link: "/privacy-policy", label: "プライバシーポリシー" },
];

export function FooterCentered() {
  return (
    <div className={classes.footer}>
      <div className={classes.inner}>
        <Group>
          {links.map((link) => (
            <Link key={link.label} href={link.link}>
              {link.label}
            </Link>
          ))}
          ©2024 withビション
        </Group>

        <Group gap="xs" justify="flex-end" wrap="nowrap">
          {/* <ActionIcon size="lg" variant="default" radius="xl">
            <IconBrandX
              style={{ width: rem(18), height: rem(18) }}
              stroke={1.5}
            />
          </ActionIcon> */}
          {/* <ActionIcon size="lg" variant="default" radius="xl">
            <IconBrandYoutube
              style={{ width: rem(18), height: rem(18) }}
              stroke={1.5}
            />
          </ActionIcon> */}
          <ActionIcon size="lg" variant="default" radius="xl">
            <Link href={"https://www.instagram.com/with_bichon/"}>
              <IconBrandInstagram
                style={{ width: rem(18), height: rem(18) }}
                stroke={1.5}
              />
            </Link>
          </ActionIcon>
        </Group>
      </div>
    </div>
  );
}
