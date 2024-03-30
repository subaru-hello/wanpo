import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  UseGuards,
} from '@nestjs/common';
import { WalkEntryService } from './walk-entry.service';
import { WalkEntry } from '@Prisma/client';
import { CreateWalkEntryDto, UpdateWalkEntryDto } from './dto';
import { JwtAuthGuard } from '@Src/guards/jwd-auth.guard';

@Controller('walk-entries')
export class WalkEntryController {
  constructor(private readonly walkEntryService: WalkEntryService) {}

  // @UseGuards(JwtAuthGuard)
  @Get(':diaryId')
  getWalkEntries(@Param('diaryId') diaryId: string): Promise<WalkEntry[]> {
    console.log('=-------', diaryId);
    return this.walkEntryService.getWalkEntries(diaryId);
  }
  // create
  @UseGuards(JwtAuthGuard)
  @Post()
  async registerWalkEntries(
    @Body() params: CreateWalkEntryDto,
  ): Promise<String> {
    return this.walkEntryService.registerWalkEntry(params);
  }
  // update
  @UseGuards(JwtAuthGuard)
  @Post(':id')
  updateOneWalkEntry(
    @Param('id') id: string,
    @Body() params: UpdateWalkEntryDto,
  ): Promise<String> {
    console.log('--------', id);
    return this.walkEntryService.updateOneWalkEntry(id, params);
  }
  // show
  @Get(':id')
  getOneWalkEntry(@Param('id') id: string): Promise<WalkEntry | String> {
    return this.walkEntryService.getOneWalkEntry(id);
  }
  // delete
  @UseGuards(JwtAuthGuard)
  @Delete(':id')
  unregisterWalkEntry(@Param('id') id: string): Promise<String> {
    return this.walkEntryService.unregisterWalkEntry(id);
  }
}
