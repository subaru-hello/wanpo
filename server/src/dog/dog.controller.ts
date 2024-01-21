import { Controller, Get } from '@nestjs/common';
import { DogService } from './dog.service';
import { Dog } from '@Prisma/client';

@Controller('dog')
export class DogController {
  constructor(private readonly dogService: DogService) {}
  @Get()
  getDogs(): Promise<Dog[]> {
    return this.dogService.getDogs();
  }

  // create

  // update

  // show

  // delete
}
