// prisma.service.ts
import { Injectable } from '@nestjs/common';
import { PrismaClient } from '@Prisma/client';

@Injectable()
export class PrismaService extends PrismaClient {
  constructor() {
    super();
  }
}
