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
      name: 'Super Dog Tamer',
      email: 'test@example.com',
      cognitoSub: 'asdfgh-qwer3ty-zxcvb-6yhjm',
      contactInfo: '123-456-7890',
    },
  });

  const taro = await prisma.dogOwner.create({
    data: {
      name: 'Super Taro',
      email: 'taro@example.com',
      cognitoSub: 'asdfgh-qwer3ty-zxcvb-6yhjm',
      contactInfo: '122-456-7890',
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
        ownerId: superDogTamer.id,
        breedId: bichon.id,
        dogProfile: {
          create: {
            bio: '白くて人懐っこいキュートなビションちゃん',
          },
        },
      },
    });

    const tama = await prisma.dog.create({
      data: {
        nickname: 'Tama',
        birthArea: 'Kanagawa',
        ownerId: taro.id,
        breedId: poodle.id,
        dogProfile: {
          create: {
            bio: '茶色くてクリクリした目が特徴のトイプードルちゃん',
          },
        },
      },
    });

    console.log({ wazzy, tama });
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
