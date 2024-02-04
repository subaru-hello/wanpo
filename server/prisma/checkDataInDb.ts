import { PrismaClient } from '@Prisma/client';

async function main() {
  const prisma = new PrismaClient();

  const owners = await prisma.dogOwnerProfile.findMany({
    include: {
      dogs: true,
    },
  });
  const dogs = await prisma.dog.findMany();
  const dogBreeds = await prisma.dogBreed.findMany();
  const diaries = await prisma.diary.findMany();
  console.log(
    'owners',
    owners,
    'breed:',
    dogBreeds,
    'diaries:',
    diaries,
    'dogs:',
    dogs,
  );
}
main();
