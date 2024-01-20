import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { DiaryModule } from './diary/diary.module';
import { DogModule } from './dog/dog.module';
import { PrismaModule } from './prisma/prisma.module';
@Module({
  imports: [DiaryModule, DogModule, PrismaModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
