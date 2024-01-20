import { Controller, Get } from '@nestjs/common';
import { DiaryService } from './diary.service';

@Controller('diary')
export class DiaryController {
  constructor(private readonly diaryService: DiaryService) {}
  @Get()
  getHello(): string {
    return this.diaryService.getDiary();
  }
}
