import { Module } from '@nestjs/common';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { ConfigService } from '@nestjs/config';
import { DogOwnerService } from '@Src/dog-owner/dog-owners.service';
import { PrismaModule } from '@Src/prisma/prisma.module';
@Module({
  controllers: [AuthController],
  imports: [PrismaModule],
  providers: [AuthService, ConfigService, DogOwnerService],
  exports: [AuthService],
})
export class AuthModule {}
