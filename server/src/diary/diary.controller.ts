import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  UseGuards,
} from '@nestjs/common';
import { DiaryService } from './diary.service';
import { Diary } from '@Prisma/client';
import { CreateDiaryDto, UpdateDiaryDto } from './dto';
import { JwtAuthGuard } from '@Src/guards/jwd-auth.guard';

@Controller('diaries')
export class DiaryController {
  constructor(private readonly diaryService: DiaryService) {}
  @Get()
  getDiaries(): Promise<Diary[]> {
    return this.diaryService.getDiaries();
  }
  // create
  @UseGuards(JwtAuthGuard)
  @Post()
  async registerDiaries(@Body() params: CreateDiaryDto): Promise<String> {
    console.log('=====', params);
    return this.diaryService.registerDiary(params);
  }
  // update
  @UseGuards(JwtAuthGuard)
  @Patch(':id')
  updateOneDiary(
    @Param('id') id: string,
    @Body() params: UpdateDiaryDto,
  ): Promise<String> {
    return this.diaryService.updateOneDiary(id, params);
  }
  // show
  @Get(':id')
  getOneDiary(@Param('id') id: string): Promise<Diary | String> {
    return this.diaryService.getOneDiary(id);
  }
  // delete
  @UseGuards(JwtAuthGuard)
  @Delete(':id')
  unregisterDiary(@Param() params: { id: string }): Promise<String> {
    return this.diaryService.unregisterDiary(params);
  }
}
