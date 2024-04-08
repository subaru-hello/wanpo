import { Country } from '@Prisma/client';

export class RegisterDogBreedDto {
  name: string;
  country: Country;
  profileImagePath: string;
}
