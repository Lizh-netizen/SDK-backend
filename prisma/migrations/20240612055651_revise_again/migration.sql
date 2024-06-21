/*
  Warnings:

  - Made the column `recordScreenId` on table `Report` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "Report" ALTER COLUMN "recordScreenId" SET NOT NULL,
ALTER COLUMN "recordScreenId" SET DATA TYPE TEXT;
