import { WalkEntryCard } from "@/components/organisms/WalkEntryCard";
import { Flex } from "@mantine/core";

async function getWalkEntries(): Promise<WalkEntry[]> {
  const apiUrl = process.env.API_URL ?? "";
  const res = await fetch(`${apiUrl}/walk-entries`);
  console.log("fetch data");
  if (!res) {
    throw new Error("no data returned");
  }
  return res.json();
}

type WalkEntry = {
  id: string;
  title: string;
  date: Date;
  stepCount?: number;
  duration?: number;
  diaryId: string;
  createdAt: Date;
  updatedAt: Date;
  unregisterdAt?: Date;
  summaryImagePath?: string;
};
export default async function Page() {
  const walkEntries = await getWalkEntries();
  console.log("data", walkEntries);
  return (
    <>
      <Flex
        mih={50}
        bg="rgba(0, 0, 0, .3)"
        gap="md"
        justify="center"
        align="center"
        direction="column"
        wrap="wrap"
      >
        {walkEntries &&
          walkEntries.map((walkEntry) => (
            <WalkEntryCard
              alt="test alt"
              src="https://picsum.photos/id/237/200/300"
              height={160}
              title={walkEntry.title}
              date={walkEntry.date}
              duaration={walkEntry.duration}
              summaryImagePath={walkEntry.summaryImagePath}
            />
          ))}
      </Flex>
    </>
  );
}
