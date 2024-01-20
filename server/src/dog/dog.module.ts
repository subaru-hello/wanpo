import { Module } from '@nestjs/common';
import { DogController } from './dog.controller';
import { DogService } from './dog.service';
import { PrismaService } from 'src/prisma/prisma.service';

@Module({
  controllers: [DogController],
  providers: [DogService, PrismaService],
})
export class DogModule {}
