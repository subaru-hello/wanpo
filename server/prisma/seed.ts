import { PrismaClient } from '@Prisma/client';

const prisma = new PrismaClient();

async function main() {
  // DogBreedsのシードデータを追加
  await prisma.dogBreed.createMany({
    data: [
      { name: 'Bichon Frize', country: 'FRANCE' },
      { name: 'Poodle', country: 'JAPAN' },
    ],
    skipDuplicates: true, // 重複を避ける
  });

  // DogOwnerのシードデータを追加
  const superDogTamer = await prisma.dogOwner.create({
    data: {
      email: 'test@example.com',
      cognitoSub: 'asdfgh-qwer3ty-zxcvb-6yhjm',
      dogOwnerProfile: {
        create: {
          name: 'Super Dog Tamer',
          contactInfo: '123-456-7890',
        },
      },
    },
  });

  const taro = await prisma.dogOwner.create({
    data: {
      email: 'taro@example.com',
      cognitoSub: 'asdfgh-qwer3ty-zxcvb-6yhjm',
      dogOwnerProfile: {
        create: {
          contactInfo: '122-456-7890',
          name: 'Super Taro',
        },
      },
    },
  });

  // DogBreedsを取得
  const bichon = await prisma.dogBreed.findUnique({
    where: { name: 'Bichon Frize' },
  });
  const poodle = await prisma.dogBreed.findUnique({
    where: { name: 'Poodle' },
  });

  if (bichon && poodle) {
    // Dogsのシードデータを追加
    const wazzy = await prisma.dog.create({
      data: {
        nickname: 'Wazzy',
        birthArea: 'Kumamoto',
        owner: {
          connect: {
            id: superDogTamer.id,
          },
        },
        breed: {
          connect: {
            id: bichon.id,
          },
        },
      },
    });

    const tama = await prisma.dog.create({
      data: {
        nickname: 'Tama',
        birthArea: 'Kanagawa',
        owner: {
          connect: {
            id: taro.id,
          },
        },
        breed: {
          connect: {
            id: poodle.id,
          },
        },
      },
    });

    console.log({ wazzy, tama });
  }

  const wazzy = await prisma.dog.findFirst({
    where: { nickname: 'Wazzy' },
  });
  const diaries = await prisma.diary.create({
    data: {
      title: 'わじの日記',
      description: 'わじの毎日を記録する',
      dogId: wazzy.id,
    },
  });

  const walkEntrys = [
    {
      title: 'ひやゴンスタジアムの近くを散歩したよ',
      date: '2024-01-02T00:00:00.000Z',
      stepCount: 1000,
      duration: 100,
      diaryId: diaries.id,
      summaryImagePath: null,
    },
    {
      title: '平塚の近くを散歩したよ',
      date: '2024-01-03T00:00:00.000Z',
      stepCount: 1000,
      duration: 100,
      diaryId: diaries.id,
      summaryImagePath: null,
    },
    {
      title: '代々木公園の近くを散歩したよ',
      date: '2024-01-06T00:00:00.000Z',
      stepCount: 2000,
      duration: 1003,
      diaryId: diaries.id,
      summaryImagePath: '0106.png',
    },
    {
      title: '日産スタジアムの近くを散歩したよ',
      date: '2024-01-04T00:00:00.000Z',
      stepCount: 50000,
      duration: 1003,
      diaryId: diaries.id,
      summaryImagePath: '0104.png',
    },
    {
      title: '',
      date: '2024-01-05T00:00:00.000Z',
      stepCount: 2000,
      duration: 1003,
      diaryId: diaries.id,
      summaryImagePath: '0105.png',
    },
    {
      title: '近くの公園を散歩したよ',
      date: '2024-01-03T00:00:00.000Z',
      stepCount: 1000,
      duration: 100,
      diaryId: diaries.id,
      summaryImagePath: null,
    },
  ];

  for (const entry of walkEntrys) {
    const { title, date, stepCount, duration, diaryId, summaryImagePath } =
      entry;
    await prisma.walkEntry.createMany({
      data: {
        title,
        date,
        stepCount,
        duration,
        summaryImagePath,
        diaryId: diaryId,
      },
    });
  }
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
