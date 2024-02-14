import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  UseGuards,
} from '@nestjs/common';
import { DogService } from './dog.service';
import { Dog } from '@Prisma/client';
import { CreateDogDto, UpdateDogDto } from './dto/create-dog.dto';
import { PrismaService } from '../prisma/prisma.service';
import { JwtAuthGuard } from '@Src/guards/jwd-auth.guard';

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
  @UseGuards(JwtAuthGuard)
  @Post()
  async registerDogs(@Body() params: CreateDogDto): Promise<String> {
    console.log('sssssssss', params);
    return this.dogService.registerDog(params);
  }
  // update
  @UseGuards(JwtAuthGuard)
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
  @UseGuards(JwtAuthGuard)
  @Delete(':id')
  unregisterDogs(@Param('id') id: string): Promise<String> {
    return this.dogService.unregisterDog(id);
  }
}
