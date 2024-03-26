/*
  Warnings:

  - You are about to drop the column `ownerProfileId` on the `Dog` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX "Dog_breedId_ownerProfileId_idx";

-- AlterTable
ALTER TABLE "Dog" DROP COLUMN "ownerProfileId",
ADD COLUMN     "dogOwnerProfileId" TEXT,
ADD COLUMN     "ownerId" TEXT;

-- CreateIndex
CREATE INDEX "Dog_ownerId_idx" ON "Dog"("ownerId");

-- CreateIndex
CREATE INDEX "Dog_breedId_idx" ON "Dog"("breedId");

-- CreateIndex
CREATE INDEX "Dog_dogOwnerProfileId_idx" ON "Dog"("dogOwnerProfileId");

-- CreateIndex
CREATE INDEX "Dog_breedId_ownerId_idx" ON "Dog"("breedId", "ownerId");
