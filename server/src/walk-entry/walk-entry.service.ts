import { Injectable } from '@nestjs/common';

import { WalkEntry } from '@Prisma/client';
import { PrismaService } from '../prisma/prisma.service';
import { CreateWalkEntryDto, UpdateWalkEntryDto } from './dto';
// date     DateTime
// stepCount Float?
// duration Int? // 散歩の時間（分）
// diaryId  String
// diary    Diary

@Injectable()
export class WalkEntryService {
  constructor(private readonly prisma: PrismaService) {}
  async getWalkEntries(): Promise<WalkEntry[]> {
    const walkEntries = await this.prisma.walkEntry.findMany();
    console.log('======walkEntrys=====', walkEntries);
    return walkEntries;
  }

  // create
  //   正しいパラメータじゃ無い場合error codeを返す
  async registerWalkEntry(params: CreateWalkEntryDto): Promise<String> {
    const { stepCount, duration, diaryId, date, summaryImagePath } = params;
    const walkEntry = await this.prisma.walkEntry.create({
      data: {
        stepCount: stepCount && Number(stepCount),
        duration: duration && Number(duration),
        date: date && new Date(date),
        summaryImagePath: summaryImagePath && summaryImagePath,
        diary: diaryId && {
          connect: { id: diaryId },
        },
      },
    });
    if (!walkEntry) {
      console.log('failed=====');
      return 'failed to register walkEntry';
    }
    console.log('======walkEntrys=suceeded====', walkEntry);
    return `succeeded to register ${walkEntry.date}`;
  }
  // update
  async updateOneWalkEntry(
    id: string,
    params: UpdateWalkEntryDto,
  ): Promise<String> {
    const { stepCount, duration, diaryId, date } = params;
    const walkEntry = await this.prisma.walkEntry.update({
      where: { id },
      data: {
        stepCount: stepCount && Number(stepCount),
        duration: duration && Number(duration),
        date: date && new Date(date),
        diary: diaryId && {
          connect: { id: diaryId },
        },
      },
    });
    if (!walkEntry) {
      console.log('failed=====');
      return 'failed to register walkEntry';
    }
    console.log('======walkEntrys=suceeded====', walkEntry);
    return `succeeded to update ${walkEntry}`;
  }
  // show
  async getOneWalkEntry(id: string): Promise<WalkEntry | string> {
    if (!id) {
      return 'NO_PARAM_ID';
    }
    const walkEntry = await this.prisma.walkEntry.findUnique({
      where: {
        id,
      },
    });
    if (!walkEntry) {
      console.log('failed=====');
      return 'NO_WALK_ENTRIES';
    }
    console.log('walkEntry fetch suceeded', walkEntry);
    return walkEntry;
  }

  // delete
  async unregisterWalkEntry(id: string): Promise<String> {
    if (!id) {
      return 'NO_PARAM_ID';
    }

    const deletedWalkEntry = await this.prisma.walkEntry.update({
      where: {
        id,
      },
      data: {
        unregisterdAt: new Date(),
      },
    });
    console.log('======delete=suceeded====', deletedWalkEntry);
    return `succeeded to delete ${deletedWalkEntry}`;
  }
}
