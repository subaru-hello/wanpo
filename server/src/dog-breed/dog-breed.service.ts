import { PrismaService } from '@Src/prisma/prisma.service';
import { Injectable } from '@nestjs/common';
import { DogBreed } from '@Prisma/client';
import { RegisterDogBreedDto } from './dto/register-dog-breed.dto';

@Injectable()
export class DogBreedService {
  constructor(private readonly prisma: PrismaService) {}

  async getDogBreeds(): Promise<DogBreed[]> {
    console.log('breed,', this.prisma.dogBreed.findMany({}));
    return this.prisma.dogBreed.findMany({});
  }

  async registerDogBreed(
    params: RegisterDogBreedDto,
  ): Promise<DogBreed | undefined> {
    return this.prisma.dogBreed.create({
      data: {
        name: params.name,
        country: params.country,
        profileImagePath: params.profileImagePath,
      },
    });
  }
}
