import { PrismaService } from '@Src/prisma/prisma.service';
import { Injectable } from '@nestjs/common';
import { registerDogOwnerDto } from './dto/register-dog-owner.dto';
import { DogOwner } from '@Prisma/client';

@Injectable()
export class DogOwnersService {
  constructor(private readonly prisma: PrismaService) {}
  async registerOwner(
    params: registerDogOwnerDto,
  ): Promise<DogOwner | undefined> {
    const { contactInfo, cognitoSub, name, email } = params;
    return this.prisma.dogOwner.create({
      data: {
        cognitoSub,
        email,
        dogOwnerProfile: {
          create: {
            contactInfo,
            name,
          },
        },
      },
    });
  }
  async findOne(id: string): Promise<DogOwner | undefined> {
    return this.prisma.dogOwner.findUnique({
      where: { id },
    });
  }
}
