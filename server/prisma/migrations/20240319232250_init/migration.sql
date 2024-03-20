-- CreateEnum
CREATE TYPE "Country" AS ENUM ('JAPAN', 'FRANCE');

-- CreateEnum
CREATE TYPE "ExcrementType" AS ENUM ('PIPI', 'CACA');

-- CreateEnum
CREATE TYPE "ExcrementSize" AS ENUM ('LARGE', 'MEDIUM', 'SHORT');

-- CreateEnum
CREATE TYPE "ExcrementVolume" AS ENUM ('WATERFALL', 'DROP');

-- CreateTable
CREATE TABLE "DogOwner" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "unregisterdAt" TIMESTAMP(3),
    "cognitoSub" TEXT NOT NULL,

    CONSTRAINT "DogOwner_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Dog" (
    "id" TEXT NOT NULL,
    "nickname" VARCHAR(50) NOT NULL,
    "breedId" TEXT NOT NULL,
    "birthArea" TEXT NOT NULL,
    "birthdate" TIMESTAMP(3),
    "ownerProfileId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "unregisterdAt" TIMESTAMP(3),
    "profileImagePath" TEXT,

    CONSTRAINT "Dog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DogBreed" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "country" "Country" NOT NULL DEFAULT 'JAPAN',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "profileImagePath" TEXT,

    CONSTRAINT "DogBreed_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DogOwnerProfile" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "bio" VARCHAR(200),
    "profileImagePath" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "dogOwnerId" TEXT NOT NULL,
    "contactInfo" TEXT,

    CONSTRAINT "DogOwnerProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Diary" (
    "id" TEXT NOT NULL,
    "title" VARCHAR(100) NOT NULL,
    "description" VARCHAR(1000) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "unregisterdAt" TIMESTAMP(3),
    "dogId" TEXT NOT NULL,
    "coverImagePath" TEXT,

    CONSTRAINT "Diary_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WalkEntry" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL DEFAULT '',
    "date" TIMESTAMP(3) NOT NULL,
    "stepCount" DOUBLE PRECISION,
    "duration" INTEGER,
    "diaryId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "unregisterdAt" TIMESTAMP(3),
    "summaryImagePath" TEXT,

    CONSTRAINT "WalkEntry_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Excrement" (
    "id" TEXT NOT NULL,
    "count" INTEGER DEFAULT 0,
    "type" "ExcrementType" NOT NULL DEFAULT 'PIPI',
    "size" "ExcrementSize" NOT NULL DEFAULT 'SHORT',
    "volume" "ExcrementVolume" NOT NULL DEFAULT 'DROP',
    "excramentImagePath" TEXT,
    "walkEntryId" TEXT NOT NULL,

    CONSTRAINT "Excrement_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "Dog_breedId_ownerProfileId_idx" ON "Dog"("breedId", "ownerProfileId");

-- CreateIndex
CREATE UNIQUE INDEX "DogBreed_name_key" ON "DogBreed"("name");

-- CreateIndex
CREATE UNIQUE INDEX "DogOwnerProfile_dogOwnerId_key" ON "DogOwnerProfile"("dogOwnerId");

-- CreateIndex
CREATE INDEX "DogOwnerProfile_dogOwnerId_idx" ON "DogOwnerProfile"("dogOwnerId");

-- CreateIndex
CREATE UNIQUE INDEX "Diary_dogId_key" ON "Diary"("dogId");

-- CreateIndex
CREATE INDEX "WalkEntry_diaryId_idx" ON "WalkEntry"("diaryId");

-- CreateIndex
CREATE INDEX "Excrement_walkEntryId_idx" ON "Excrement"("walkEntryId");
