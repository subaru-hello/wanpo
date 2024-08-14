import {
  Excrement,
  ExcrementSize,
  ExcrementType,
  ExcrementVolume,
} from '@Prisma/client';
import { PrismaService } from '@Src/prisma/prisma.service';
import { Injectable } from '@nestjs/common';
import { GetExcrementDto } from './dto/get-excrement.dto';

@Injectable()
export class ExcrementService {
  constructor(private readonly prisma: PrismaService) {}

  async getExcrement({ walkEntryId }: GetExcrementDto): Promise<Excrement> {
    return await this.prisma.excrement.findFirst({
      include: {
        walkEntry: true,
      },
      where: {
        walkEntryId: walkEntryId,
      },
    });
  }

  //   export type ExcrementCreateInput = {
  //     id?: string
  //     count?: number | null
  //     type?: $Enums.ExcrementType
  //     size?: $Enums.ExcrementSize
  //     volume?: $Enums.ExcrementVolume
  //     excramentImagePath?: string | null
  //     walkEntry: WalkEntryCreateNestedOneWithoutExcramentsInput
  //   }

  async registerExcrement({
    walkEntryId,
    type,
    size,
    volume,
  }: {
    walkEntryId: string;
    type: ExcrementType;
    size: ExcrementSize;
    volume: ExcrementVolume;
  }): Promise<boolean> {
    try {
      await this.prisma.excrement.create({
        data: {
          walkEntry: {
            connect: {
              id: walkEntryId,
            },
          },
          type,
          size,
          volume,
        },
      });
      return true;
    } catch (error) {
      console.log('======', error);
      return false;
    }
  }
}
