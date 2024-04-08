import { DogBreed } from '@Prisma/client';
import { Controller, Get } from '@nestjs/common';
import { DogBreedService } from './dog-breed.service';

@Controller('dog-breeds')
export class DogBreedsController {
  constructor(private readonly dogBreedService: DogBreedService) {}
  @Get()
  async getDogBreeds(): Promise<DogBreed[]> {
    return await this.dogBreedService.getDogBreeds();
  }
}
