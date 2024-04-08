import { Module } from '@nestjs/common';
import { DogOwnerService } from './dog-owners.service';
import { DogOwnersController } from './dog-owners.controller';
import { PrismaService } from '@Src/prisma/prisma.service';

@Module({
  controllers: [DogOwnersController],
  providers: [DogOwnerService, PrismaService],
  exports: [DogOwnerService],
})
export class DogOwnersModule {}
