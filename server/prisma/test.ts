import { PrismaClient } from '@Prisma/client';

async function main() {
  const prisma = new PrismaClient();
  const dogs = await prisma.dog.findMany();
  const dogProfiles = await prisma.dogProfile.findMany();
  const dogBreeds = await prisma.dogBreed.findMany();
  const diaries = await prisma.diary.findMany();
  console.log('------', dogs, dogProfiles, dogBreeds, diaries);
}
main();
