import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { DiaryModule } from './diary/diary.module';
import { DogModule } from './dog/dog.module';
import { PrismaModule } from './prisma/prisma.module';
import { WalkEntryModule } from './walk-entry/walk-entry.module';
import { AuthModule } from './auth/auth.module';
import { DogOwnersModule } from './dog-owners/dog-owners.module';
import { ConfigModule } from '@nestjs/config';
@Module({
  imports: [
    DiaryModule,
    DogModule,
    PrismaModule,
    WalkEntryModule,
    AuthModule,
    DogOwnersModule,
    ConfigModule.forRoot({
      isGlobal: true,
    }),
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
