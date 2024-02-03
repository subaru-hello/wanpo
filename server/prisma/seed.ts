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
            dogOwnerId: superDogTamer.id,
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
            dogOwnerId: taro.id,
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
