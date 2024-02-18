import { WalkEntryCard } from "@/components/organisms/WalkEntryCard";

async function getWalkEntries() {
  const res = await fetch(
    "https://hvq7w1zwg3.execute-api.ap-northeast-1.amazonaws.com"
  );
  console.log("fetch data");
  if (!res) {
    throw new Error("no data returned");
  }
  return res.json();
}

export default async function Page() {
  const data = await getWalkEntries();
  console.log("data", data);
  return (
    <WalkEntryCard
      alt="test alt"
      src="https://picsum.photos/id/237/200/300"
      height={160}
    />
  );
}
