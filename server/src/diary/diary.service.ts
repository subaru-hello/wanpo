import { Diary } from '@Prisma/client';
import { PrismaService } from '@Src/prisma/prisma.service';
import { Injectable } from '@nestjs/common';
import { CreateDiaryDto, UpdateDiaryDto } from './dto';

@Injectable()
export class DiaryService {
  constructor(private readonly prisma: PrismaService) {}
  async getDiaries(): Promise<Diary[]> {
    return await this.prisma.diary.findMany();
  }
  // create
  //   正しいパラメータじゃ無い場合error codeを返す
  async registerDiary(params: CreateDiaryDto): Promise<String> {
    const { title, description, unregisterdAt, dogId, coverImagePath } = params;
    const diary = await this.prisma.diary.create({
      data: {
        title,
        description,
        unregisterdAt: unregisterdAt && new Date(unregisterdAt),
        coverImagePath: coverImagePath && coverImagePath,
        dog: dogId && {
          connect: { id: dogId },
        },
      },
    });
    if (!diary) {
      console.log('failed=====');
      return 'failed to register diary';
    }
    console.log('======diarys=suceeded====', diary);
    return `succeeded to register ${diary.title}`;
  }
  // update
  async updateOneDiary(id: string, params: UpdateDiaryDto): Promise<String> {
    const { title, description, unregisterdAt, dogId, coverImagePath } = params;
    if (!id) {
      return 'ID_REQUIRED';
    }
    console.log(params);
    const diary = await this.prisma.diary.update({
      where: { id },
      data: {
        title,
        description,
        coverImagePath: coverImagePath && coverImagePath,
        unregisterdAt: unregisterdAt && new Date(unregisterdAt),
        dog: dogId && {
          connect: { id: dogId },
        },
      },
    });
    if (!diary) {
      console.log('failed=====');
      return 'failed to register diary';
    }
    console.log('======diarys=suceeded====', diary);
    return `succeeded to update ${diary.title}`;
  }
  // show
  async getOneDiary(id: string): Promise<Diary | string> {
    if (!id) {
      return 'ID_REQUIRED';
    }
    const diary = await this.prisma.diary.findUnique({
      where: {
        id,
      },
    });
    if (!diary) {
      console.log('failed=====');
      return 'NO_DIARY';
    }
    console.log('diary fetch suceeded', diary.title);
    return diary;
  }

  // delete
  async unregisterDiary(params: { id: string }): Promise<String> {
    const { id } = params;
    if (!id) {
      return 'ID_REQUIRED';
    }

    const deletedDiary = await this.prisma.diary.update({
      where: {
        id,
      },
      data: {
        unregisterdAt: new Date(),
      },
    });
    console.log('======delete=suceeded====', deletedDiary);
    return `succeeded to delete ${deletedDiary.title}`;
  }
}
