import { Module } from '@nestjs/common';
import { S3Service } from '@Src/aws/s3/s3.service';

@Module({
  controllers: [],
  providers: [S3Service],
})
export class S3Module {}
