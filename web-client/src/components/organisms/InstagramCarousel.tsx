"use client";
import "@mantine/carousel/styles.css";
import { Carousel } from "@mantine/carousel";
import Autoplay from "embla-carousel-autoplay";
import { useMediaQuery } from "@mantine/hooks";
import { Button, Paper, Title, Text, useMantineTheme } from "@mantine/core";
import { InstagramEmbed } from "react-social-media-embed";
import classes from "@/assets/InstagramCarousel.module.css";
import { useRef } from "react";

const data = [
  {
    image: "https://www.instagram.com/p/C3h7CzXRRc5/?img_index=1",
    title: "Best forests to visit in North America",
    category: "nature",
  },
  {
    image: "https://www.instagram.com/p/C3h65h8xMfB/?img_index=1",
    title: "Hawaii beaches review: better than you think",
    category: "beach",
  },
  {
    image: "https://www.instagram.com/p/C3h65h8xMfB/?img_index=3",
    title: "Mountains at night: 12 best locations to enjoy the view",
    category: "nature",
  },
  {
    image: "https://www.instagram.com/p/C3P7U_rxqao/",
    title: "Aurora in Norway: when to visit for best experience",
    category: "nature",
  },
];

interface CardProps {
  image: string;
  title: string;
  category: string;
}

function Card({ image, title, category }: CardProps) {
  return (
    <Paper
      shadow="md"
      p="xl"
      radius="md"
      //   style={{ backgroundImage: `url(${image})` }}
      className={classes.card}
    >
      <div>
        <InstagramEmbed url={image} width={328} height={500} />
        <Text className={classes.category} size="xs">
          {category}
        </Text>
        <Title order={3} className={classes.title}>
          {title}
        </Title>
      </div>
      <Button variant="white" color="dark">
        Read article
      </Button>
    </Paper>
  );
}

export default function InstagramCaroucel() {
  const theme = useMantineTheme();
  const autoplay = useRef(Autoplay({ delay: 2000 }));
  const mobile = useMediaQuery(`(max-width: ${theme.breakpoints.sm})`);
  const slides = data.map((item) => (
    <Carousel.Slide key={item.title}>
      <InstagramEmbed url={item.image} width={328} height={500} />
      {/* <Card {...item} /> */}
    </Carousel.Slide>
  ));

  return (
    <Carousel
      slideSize={{ base: "100%", sm: "50%" }}
      slideGap={{ base: "xl", sm: 2 }}
      align="start"
      slidesToScroll={mobile ? 1 : 2}
      withIndicators
      //   height={200}
      plugins={[autoplay.current]}
      onMouseEnter={autoplay.current.stop}
      onMouseLeave={autoplay.current.reset}
    >
      {slides}
    </Carousel>
  );
}
