import { Dog } from '@Prisma/client';

export class registerDogOwnerDto {
  id: string;
  name: string;
  email: string;
  createdAt: Date;
  updatedAt: Date;
  unregisterdAt?: Date;
  cognitoSub: string;
  contactInfo?: string;
  dogs: Dog[];
}
