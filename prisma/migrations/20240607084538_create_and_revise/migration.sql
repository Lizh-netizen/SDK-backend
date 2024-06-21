/*
  Warnings:

  - You are about to drop the `Error` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE "Error";

-- CreateTable
CREATE TABLE "ReportData" (
    "id" SERIAL NOT NULL,
    "type" TEXT NOT NULL,
    "pageUrl" TEXT NOT NULL,
    "time" TIMESTAMP(3) NOT NULL,
    "uuid" TEXT NOT NULL,
    "apikey" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "browserVersion" TEXT,
    "browser" TEXT,
    "osVersion" TEXT,
    "os" TEXT,
    "ua" TEXT,
    "device" TEXT,
    "deviceType" TEXT,

    CONSTRAINT "ReportData_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ErrorData" (
    "id" SERIAL NOT NULL,
    "reportId" INTEGER NOT NULL,
    "type" TEXT NOT NULL,
    "time" TIMESTAMP(3) NOT NULL,
    "message" TEXT NOT NULL,
    "url" TEXT,
    "method" TEXT,
    "statusCode" INTEGER,
    "elapsedTime" INTEGER,
    "name" TEXT,
    "fileName" TEXT,
    "line" INTEGER,
    "column" INTEGER,
    "context" JSONB NOT NULL,

    CONSTRAINT "ErrorData_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RecordScreen" (
    "id" SERIAL NOT NULL,
    "reportId" INTEGER NOT NULL,
    "recordScreenId" TEXT NOT NULL,
    "events" TEXT NOT NULL,

    CONSTRAINT "RecordScreen_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ReportData_uuid_key" ON "ReportData"("uuid");

-- CreateIndex
CREATE UNIQUE INDEX "RecordScreen_reportId_key" ON "RecordScreen"("reportId");

-- AddForeignKey
ALTER TABLE "ErrorData" ADD CONSTRAINT "ErrorData_reportId_fkey" FOREIGN KEY ("reportId") REFERENCES "ReportData"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RecordScreen" ADD CONSTRAINT "RecordScreen_reportId_fkey" FOREIGN KEY ("reportId") REFERENCES "ReportData"("id") ON DELETE CASCADE ON UPDATE CASCADE;
