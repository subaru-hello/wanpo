import { Country, PrismaClient } from './generated/client';
const prisma = new PrismaClient();
async function main() {
  const dogBreeds = await prisma.dogBreed.createMany({
    data: [
      { name: 'Bichon Frize', country: Country.FRANCE },
      { name: 'Poodle', country: Country.JAPAN },
    ],
  });
  const bichon = await prisma.dogBreed.findUnique({
    where: { name: 'Bichon Frize' },
  });
  const poodle = await prisma.dogBreed.findUnique({
    where: { name: 'Poodle' },
  });
  const wazzy = await prisma.dog.create({
    data: {
      nickname: 'wazzy',
      birthArea: 'kumamoto',
      dogProfile: {
        create: {
          bio: '白くて人懐っこいキュートなビションちゃん',
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
      nickname: 'tama',
      birthArea: 'kanagawa',
      dogProfile: {
        create: {
          bio: '茶色くてクリクリした目が特徴のトイプードルちゃん',
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
main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
