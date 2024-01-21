import { Injectable } from '@nestjs/common';
import { Dog } from '@Prisma/client';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class DogService {
  constructor(private readonly prisma: PrismaService) {}
  async getDogs(): Promise<Dog[]> {
    const dogs = await this.prisma.dog.findMany();
    console.log('======dogs=====');
    return dogs;
  }

  // create

  // update

  // show

  // delete
}
