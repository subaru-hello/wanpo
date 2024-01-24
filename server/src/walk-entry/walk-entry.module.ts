import { Module } from '@nestjs/common';
import { WalkEntryController } from './walk-entry.controller';
import { PrismaService } from '@Src/prisma/prisma.service';
import { WalkEntryService } from './walk-entry.service';

@Module({
  controllers: [WalkEntryController],
  providers: [WalkEntryService, PrismaService],
})
export class WalkEntryModule {}
