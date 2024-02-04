import { Module } from '@nestjs/common';
import { DogOwnersService } from './dog-owners.service';
import { DogOwnersController } from './dog-owners.controller';
import { PrismaService } from '@Src/prisma/prisma.service';

@Module({
  controllers: [DogOwnersController],
  providers: [DogOwnersService, PrismaService],
  exports: [DogOwnersService],
})
export class DogOwnersModule {}
