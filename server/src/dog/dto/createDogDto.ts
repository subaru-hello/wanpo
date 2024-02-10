import { IsNotEmpty } from 'class-validator';

export class CreateDogDto {
  @IsNotEmpty()
  nickname: string;

  birthArea: string;

  birthdate?: string;

  breedId: string;

  ownerId: string;
  profileImage?: string;
}

export class UpdateDogDto {
  nickname: string;

  birthArea: string;

  birthdate?: string;

  breedId?: string;

  ownerId?: string;

  profileImagePath?: string;
}
