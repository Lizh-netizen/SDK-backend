/*
  Warnings:

  - You are about to drop the column `column` on the `ErrorData` table. All the data in the column will be lost.
  - You are about to drop the column `elapsedTime` on the `ErrorData` table. All the data in the column will be lost.
  - You are about to drop the column `fileName` on the `ErrorData` table. All the data in the column will be lost.
  - You are about to drop the column `line` on the `ErrorData` table. All the data in the column will be lost.
  - You are about to drop the column `method` on the `ErrorData` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `ErrorData` table. All the data in the column will be lost.
  - You are about to drop the column `statusCode` on the `ErrorData` table. All the data in the column will be lost.
  - You are about to drop the column `url` on the `ErrorData` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "ErrorData" DROP COLUMN "column",
DROP COLUMN "elapsedTime",
DROP COLUMN "fileName",
DROP COLUMN "line",
DROP COLUMN "method",
DROP COLUMN "name",
DROP COLUMN "statusCode",
DROP COLUMN "url";
