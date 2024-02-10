import { Module } from '@nestjs/common';
import { DogController } from './dog.controller';
import { DogService } from './dog.service';
import { PrismaService } from 'src/prisma/prisma.service';
import { DogProfileImageController } from './dogProfileImage/dog-profile-image.controller';
import { S3Service } from '@Src/aws/s3/s3.service';

@Module({
  controllers: [DogController, DogProfileImageController],
  providers: [DogService, PrismaService, S3Service],
})
export class DogModule {}
