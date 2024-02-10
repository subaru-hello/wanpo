import { Injectable } from '@nestjs/common';
import { PresignedUrlDto } from './dto/prisigned-url.dto';
import {
  GetObjectCommand,
  PutObjectCommand,
  S3Client,
} from '@aws-sdk/client-s3';
import { getSignedUrl } from '@aws-sdk/s3-request-presigner';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class S3Service {
  constructor(private configService: ConfigService) {}
  s3Config = () => {
    return new S3Client({
      region: this.configService.get<string>('AWS_REGION'),
      credentials: {
        secretAccessKey: this.configService.get<string>('AWS_SECRET_KEY'),
        accessKeyId: this.configService.get<string>('AWS_ACCESS_KEY'),
      },
    });
  };
  createPresignedUrl = async ({
    bucket,
    key,
    operation,
    ttl,
  }: PresignedUrlDto) => {
    const client = this.s3Config();
    // 署名付きURLを生成
    const operatoinMap = {
      UPLOAD: new PutObjectCommand({
        Bucket: bucket,
        Key: key,
      }),
      DOWNLOAD: new GetObjectCommand({
        Bucket: bucket,
        Key: key,
      }),
    };
    const command = operatoinMap[operation];
    return await getSignedUrl(client, command, { expiresIn: ttl });
  };
}
