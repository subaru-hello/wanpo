import { Excrement } from '@Prisma/client';
import { Controller, Get } from '@nestjs/common';
import { ExcrementService } from './excrement.service';
import { GetExcrementDto } from './dto/get-excrement.dto';

@Controller('excrement')
export class ExcrementController {
  constructor(private readonly excrementService: ExcrementService) {}
  @Get()
  async getExcrement(params: GetExcrementDto): Promise<Excrement> {
    return await this.excrementService.getExcrement(params);
  }
}
