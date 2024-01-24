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
import { DogService } from './dog.service';
import { Dog } from '@Prisma/client';
import { CreateDogDto, UpdateDogDto } from './dto/createDogDto';
import { PrismaService } from '../prisma/prisma.service';

@Controller('dogs')
export class DogController {
  constructor(
    private readonly dogService: DogService,
    private readonly prisma: PrismaService,
  ) {}
  @Get()
  getDogs(): Promise<Dog[]> {
    return this.dogService.getDogs();
  }
  // create
  @Post()
  async registerDogs(@Body() params: CreateDogDto): Promise<String> {
    console.log('sssssssss', params);
    return this.dogService.registerDog(params);
  }
  // update
  @Patch(':id')
  updateOneDog(
    @Param('id') id: string,
    @Body() params: UpdateDogDto,
  ): Promise<String> {
    console.log('===', params);
    return this.dogService.updateOneDog(id, params);
  }
  // show
  @Get(':id')
  getOneDog(@Param('id') id: string): Promise<Dog | String> {
    return this.dogService.getOneDog(id);
  }
  // delete
  @Delete(':id')
  unregisterDogs(@Param('id') id: string): Promise<String> {
    return this.dogService.unregisterDog(id);
  }
}
