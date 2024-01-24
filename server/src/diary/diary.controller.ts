import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
} from '@nestjs/common';
import { DiaryService } from './diary.service';
import { Diary } from '@Prisma/client';
import { PrismaService } from '@Src/prisma/prisma.service';
import { CreateDiaryDto, UpdateDiaryDto } from './dto';

@Controller('diaries')
export class DiaryController {
  constructor(
    private readonly diaryService: DiaryService,
    private readonly prisma: PrismaService,
  ) {}
  @Get()
  getDiaries(): Promise<Diary[]> {
    return this.diaryService.getDiaries();
  }
  // create
  @Post()
  async registerDiaries(@Body() params: CreateDiaryDto): Promise<String> {
    console.log('sssssssss', params);
    return this.diaryService.registerDiary(params);
  }
  // update
  @Patch(':id')
  updateOneDiary(
    @Param('id') id: string,
    @Body() params: UpdateDiaryDto,
  ): Promise<String> {
    console.log('===', params);
    return this.diaryService.updateOneDiary(id, params);
  }
  // show
  @Get(':id')
  getOneDiary(@Param('id') id: string): Promise<Diary | String> {
    return this.diaryService.getOneDiary(id);
  }
  // delete
  @Delete(':id')
  unregisterDiary(@Param() params: { id: string }): Promise<String> {
    console.log('-----', params);
    return this.diaryService.unregisterDiary(params);
  }
}
