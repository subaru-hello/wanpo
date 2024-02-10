import { Body, Controller, Get, Post } from '@nestjs/common';
import { S3Service } from '@Src/aws/s3/s3.service';
import { PresignedUrlDto } from '@Src/aws/s3/dto/prisigned-url.dto';

@Controller('dogs/profile-image')
export class DogProfileImageController {
  constructor(private readonly s3Service: S3Service) {}
  @Post()
  getProfilePresignedUrl(@Body() params: PresignedUrlDto): Promise<string> {
    return this.s3Service.createPresignedUrl(params);
  }
}
