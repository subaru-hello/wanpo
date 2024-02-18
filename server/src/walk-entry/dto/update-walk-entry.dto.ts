import { IsNotEmpty } from 'class-validator';

export class UpdateWalkEntryDto {
  @IsNotEmpty()
  date: string;

  stepCount?: number;

  duration?: number;

  diaryId: string;

  title?: string;
}
