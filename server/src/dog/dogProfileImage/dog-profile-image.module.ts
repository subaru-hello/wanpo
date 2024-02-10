import { Module } from '@nestjs/common';
import { S3Service } from '@Src/aws/s3/s3.service';
import { DogProfileImageController } from './dog-profile-image.controller';

@Module({
  controllers: [DogProfileImageController],
  providers: [S3Service],
})
export class DogProfileImageModule {}
