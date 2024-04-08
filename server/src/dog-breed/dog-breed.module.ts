import { Module } from '@nestjs/common';
import { PrismaService } from '@Src/prisma/prisma.service';
import { DogBreedService } from './dog-breed.service';
import { DogBreedsController } from './dog-breed.controller';

@Module({
  controllers: [DogBreedsController],
  providers: [DogBreedService, PrismaService],
  exports: [DogBreedService],
})
export class DogBreedsModule {}
