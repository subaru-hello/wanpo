import { Injectable } from '@nestjs/common';
import { Dog } from '@Prisma/client';
import { PrismaService } from '../prisma/prisma.service';
import { CreateDogDto, UpdateDogDto } from './dto/createDogDto';

@Injectable()
export class DogService {
  constructor(private readonly prisma: PrismaService) {}
  async getDogs(): Promise<Dog[]> {
    const dogs = await this.prisma.dog.findMany();
    console.log('======dogs=====');
    return dogs;
  }

  // create
  //   正しいパラメータじゃ無い場合error codeを返す
  async registerDog(params: CreateDogDto): Promise<String> {
    const { nickname, birthArea, birthdate, ownerId, breedId } = params;
    console.log('--------', birthdate, new Date(birthdate));
    const dog = await this.prisma.dog.create({
      data: {
        nickname,
        birthArea,
        owner: ownerId && {
          connect: { id: ownerId },
        },
        breed: breedId && {
          connect: {
            id: breedId,
          },
        },
        birthdate: birthdate && new Date(birthdate),
      },
    });
    if (!dog) {
      console.log('failed=====');
      return 'failed to register dog';
    }
    console.log('======dogs=suceeded====', dog);
    return `succeeded to register ${dog.nickname}`;
  }
  // update
  async updateOneDog(id: string, params: UpdateDogDto): Promise<String> {
    if (!id) {
      return 'NO_PARAM_ID';
    }
    const { birthdate, breedId, ownerId } = params;
    const dog = await this.prisma.dog.update({
      where: {
        id: id,
      },
      data: {
        birthdate: birthdate && new Date(birthdate),
        breed: breedId && {
          connect: {
            id: breedId,
          },
        },
        owner: ownerId && {
          connect: {
            id: ownerId,
          },
        },
      },
    });
    if (!dog) {
      console.log('failed=====');
      return 'failed to register dog';
    }
    console.log('======dogs=suceeded====', dog);
    return `succeeded to update ${dog.nickname}`;
  }
  // show
  async getOneDog(id: string): Promise<Dog | string> {
    if (!id) {
      return 'NO_PARAM_ID';
    }
    const dog = await this.prisma.dog.findUnique({
      where: {
        id,
      },
    });
    if (!dog) {
      console.log('failed=====');
      return 'NO_DOGS';
    }
    console.log('dog fetch suceeded', dog);
    return dog;
  }

  // delete
  async unregisterDog(id: string): Promise<String> {
    if (!id) {
      return 'NO_PARAM_ID';
    }

    const deletedDog = await this.prisma.dog.update({
      where: {
        id,
      },
      data: {
        unregisterdAt: new Date(),
      },
    });
    console.log('======delete=suceeded====', deletedDog);
    return `succeeded to delete ${deletedDog.nickname}`;
  }
}
