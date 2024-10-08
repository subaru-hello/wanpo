import { Excrement } from '@Prisma/client';
import { IsNotEmpty } from 'class-validator';
// date     DateTime
// stepCount Float?
// duration Int? // 散歩の時間（分）
// diaryId  String
export class CreateWalkEntryDto {
  @IsNotEmpty()
  date: string;

  stepCount?: number;

  duration?: number;

  description?: string;

  title: string;

  @IsNotEmpty()
  diaryId: string;

  summaryImagePath?: string;

  excraments?: Excrement;
}
