/*
  Warnings:

  - You are about to drop the column `recordScreenKey` on the `RecordScreen` table. All the data in the column will be lost.
  - You are about to drop the column `errorMessage` on the `Report` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[recordScreenId]` on the table `RecordScreen` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `recordScreenId` to the `RecordScreen` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "RecordScreen_recordScreenKey_key";

-- AlterTable
ALTER TABLE "RecordScreen" DROP COLUMN "recordScreenKey",
ADD COLUMN     "recordScreenId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Report" DROP COLUMN "errorMessage",
ADD COLUMN     "message" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "RecordScreen_recordScreenId_key" ON "RecordScreen"("recordScreenId");
