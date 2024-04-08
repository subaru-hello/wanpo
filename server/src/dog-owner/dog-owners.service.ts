import { PrismaService } from '@Src/prisma/prisma.service';
import { Injectable } from '@nestjs/common';
import { registerDogOwnerDto } from './dto/register-dog-owner.dto';
import { DogOwner } from '@Prisma/client';
import { randomUUID } from 'crypto';

@Injectable()
export class DogOwnerService {
  constructor(private readonly prisma: PrismaService) {}
  async registerOwner(
    params: registerDogOwnerDto,
  ): Promise<DogOwner | undefined> {
    return this.prisma.dogOwner.create({
      data: {
        cognitoSub: randomUUID(), // randomで生成しておいて、verifyが完了した時にcognitoSubをアップデートさせる not null制約対策
        email: params.email,
        // プロフィールは、サインアップ後初めての画面で作成必須にしておく。
      },
    });
  }

  async updateOwnerInfo(params: any) {
    const targetOwner = await this.prisma.dogOwner.findFirst({
      where: { email: params.email },
    });
    try {
      await this.prisma.dogOwner.update({
        where: {
          id: targetOwner.id,
        },
        data: {
          email: params.email,
          dogs: params.dogs,
          unregisterdAt: params.unregisterdAt,
          dogOwnerProfile: params.dogOwnerProfile,
          cognitoSub: params.cognitoSub,
        },
      });
    } catch (error) {
      console.log('update owner info failed', error);
      throw new Error(error);
    }
  }

  async findUnVerifiedOwner(params: {
    id: string;
  }): Promise<DogOwner | undefined> {
    const timeNow = new Date();
    // 10分前の日時をミリ秒で計算
    const tenMinutesAgo = new Date(timeNow.getTime() - 10 * 60000);

    return this.prisma.dogOwner.findFirst({
      where: {
        ...params,
        createdAt: {
          lt: tenMinutesAgo,
        },
      },
    });
  }

  async findOne(params: {
    id?: string;
    email?: string;
    cognitoSub?: string;
  }): Promise<DogOwner | undefined> {
    return this.prisma.dogOwner.findFirst({
      where: { ...params },
    });
  }

  async unRegisterOwner(params: { email: string }): Promise<boolean> {
    const { email } = params;
    const timeNow = new Date();
    const targetDogOwner = await this.prisma.dogOwner.findFirst({
      where: {
        email,
        // プロフィールは、サインアップ後初めての画面で作成必須にしておく。
      },
    });
    if (!targetDogOwner) {
      throw new Error('NOT_FOUND_DOG_OWNER');
    }

    try {
      await this.prisma.dogOwner.update({
        where: {
          id: targetDogOwner.id,
        },
        data: {
          unregisterdAt: timeNow,
        },
      });
      return true;
    } catch (error) {
      console.log('update the dog owner error', error);
      throw new Error(error);
    }
  }
}
