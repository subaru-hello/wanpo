import { Module } from '@nestjs/common';
import { ExcrementService } from './excrement.service';

@Module({
  providers: [ExcrementService]
})
export class ExcrementModule {}
