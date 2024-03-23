import {
  Body,
  Controller,
  Delete,
  Get,
  HttpStatus,
  Param,
  Patch,
  Post,
  Req,
  Res,
  UseGuards,
} from '@nestjs/common';
import { DogService } from './dog.service';
import { Dog } from '@Prisma/client';
import { CreateDogDto, UpdateDogDto } from './dto/create-dog.dto';
import { PrismaService } from '../prisma/prisma.service';
import { JwtAuthGuard } from '@Src/guards/jwd-auth.guard';
import { Request, Response } from 'express';
import { getCognitoSubFromCookie } from '@Src/auth/utils/httpUtils';

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
  @Get('owned-dogs')
  async getOwnedDogs(
    @Req() req: Request,
    @Res() res: Response,
  ): Promise<Response<Promise<Dog[]>>> {
    const cognitoSub = getCognitoSubFromCookie(req) ?? undefined;
    const dogs = await this.dogService.getOwnedDogs(cognitoSub);
    return res.status(HttpStatus.OK).json({ dogs });
  }
  // create
  @UseGuards(JwtAuthGuard)
  @Post()
  async registerDogs(@Body() params: CreateDogDto): Promise<String> {
    return this.dogService.registerDog(params);
  }
  // update
  @UseGuards(JwtAuthGuard)
  @Patch(':id')
  updateOneDog(
    @Param('id') id: string,
    @Body() params: UpdateDogDto,
  ): Promise<String> {
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
