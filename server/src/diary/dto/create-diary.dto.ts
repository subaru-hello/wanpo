import { IsNotEmpty } from 'class-validator';
export class CreateDiaryDto {
  @IsNotEmpty()
  title: string;

  description: string;

  unregisterdAt?: string;

  dogId: string;

  coverImagePath: string;
}
