/*
  Warnings:

  - You are about to drop the column `recordScreenId` on the `RecordScreen` table. All the data in the column will be lost.
  - You are about to drop the column `reportId` on the `RecordScreen` table. All the data in the column will be lost.
  - You are about to drop the `ErrorData` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ReportData` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[recordScreenKey]` on the table `RecordScreen` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `recordScreenKey` to the `RecordScreen` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "ErrorData" DROP CONSTRAINT "ErrorData_reportId_fkey";

-- DropForeignKey
ALTER TABLE "RecordScreen" DROP CONSTRAINT "RecordScreen_reportId_fkey";

-- DropIndex
DROP INDEX "RecordScreen_reportId_key";

-- AlterTable
ALTER TABLE "RecordScreen" DROP COLUMN "recordScreenId",
DROP COLUMN "reportId",
ADD COLUMN     "recordScreenKey" TEXT NOT NULL;

-- DropTable
DROP TABLE "ErrorData";

-- DropTable
DROP TABLE "ReportData";

-- CreateTable
CREATE TABLE "Report" (
    "id" SERIAL NOT NULL,
    "type" TEXT NOT NULL,
    "pageUrl" TEXT,
    "time" TIMESTAMP(3) NOT NULL,
    "uuid" TEXT NOT NULL,
    "apikey" TEXT NOT NULL,
    "status" TEXT,
    "browserVersion" TEXT,
    "browser" TEXT,
    "osVersion" TEXT,
    "os" TEXT,
    "ua" TEXT,
    "device" TEXT,
    "deviceType" TEXT,
    "recordScreenId" INTEGER,
    "errorMessage" TEXT,
    "errorContext" JSONB,

    CONSTRAINT "Report_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Report_uuid_key" ON "Report"("uuid");

-- CreateIndex
CREATE INDEX "Report_recordScreenId_idx" ON "Report"("recordScreenId");

-- CreateIndex
CREATE UNIQUE INDEX "RecordScreen_recordScreenKey_key" ON "RecordScreen"("recordScreenKey");
