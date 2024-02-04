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
import { ThrottlerGuard, ThrottlerModule } from '@nestjs/throttler';
import { APP_GUARD } from '@nestjs/core';
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
    // Throttle guard
    // {"statusCode":429,"message":"ThrottlerException: Too Many Requests"}%
    ThrottlerModule.forRoot([
      {
        name: 'short',
        ttl: 1000,
        limit: 3,
      },
      {
        name: 'medium',
        ttl: 10000,
        limit: 20,
      },
      {
        name: 'long',
        ttl: 60000,
        limit: 100,
      },
    ]),
  ],
  controllers: [AppController],
  providers: [
    AppService,
    {
      provide: APP_GUARD,
      useClass: ThrottlerGuard,
    },
  ],
})
export class AppModule {}
