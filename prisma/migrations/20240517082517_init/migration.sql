-- CreateTable
CREATE TABLE "Error" (
    "id" SERIAL NOT NULL,
    "hash" TEXT NOT NULL,
    "fileName" TEXT NOT NULL,
    "lineNumber" INTEGER NOT NULL,
    "columnNumber" INTEGER NOT NULL,
    "domInfo" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Error_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Error_hash_key" ON "Error"("hash");
