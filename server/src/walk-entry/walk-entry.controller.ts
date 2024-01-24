import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  Req,
} from '@nestjs/common';
import { WalkEntryService } from './walk-entry.service';
import { WalkEntry } from '@Prisma/client';
import { CreateWalkEntryDto, UpdateWalkEntryDto } from './dto';

@Controller('walk-entries')
export class WalkEntryController {
  constructor(private readonly walkEntryService: WalkEntryService) {}
  @Get()
  getWalkEntries(): Promise<WalkEntry[]> {
    return this.walkEntryService.getWalkEntries();
  }
  // create
  @Post()
  async registerWalkEntries(
    @Body() params: CreateWalkEntryDto,
  ): Promise<String> {
    console.log('sssssssss', params);
    return this.walkEntryService.registerWalkEntry(params);
  }
  // update
  @Patch(':id')
  updateOneWalkEntry(
    @Param('id') id: string,
    @Body() params: UpdateWalkEntryDto,
  ): Promise<String> {
    console.log('===', params);
    return this.walkEntryService.updateOneWalkEntry(id, params);
  }
  // show
  @Get(':id')
  getOneWalkEntry(@Param('id') id: string): Promise<WalkEntry | String> {
    return this.walkEntryService.getOneWalkEntry(id);
  }
  // delete
  @Delete(':id')
  unregisterWalkEntry(@Param('id') id: string): Promise<String> {
    return this.walkEntryService.unregisterWalkEntry(id);
  }
}
