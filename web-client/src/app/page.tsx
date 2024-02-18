import Link from "next/link";

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
      {/* header */}
      {/* sWaiper section */}
      <Link href="/walk-entries">お出かけ記録一覧</Link>
      {/* footer */}
    </main>
  );
}
