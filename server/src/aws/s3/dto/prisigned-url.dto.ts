export class PresignedUrlDto {
  bucket: string;
  key: string;
  operation: 'UPLOAD' | 'DOWNLOAD';
  ttl: number;
}
