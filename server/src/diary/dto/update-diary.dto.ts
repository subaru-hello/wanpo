import { IsNotEmpty } from 'class-validator';

export class UpdateDiaryDto {
  @IsNotEmpty()
  title: string;
  description: string;
  unregisterdAt?: string;
  coverImagePath?: string;
  dogId: string;
}
