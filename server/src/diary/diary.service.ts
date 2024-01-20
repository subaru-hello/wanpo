import { Injectable } from '@nestjs/common';

@Injectable()
export class DiaryService {
  getDiary(): string {
    return 'Diary!';
  }
}
