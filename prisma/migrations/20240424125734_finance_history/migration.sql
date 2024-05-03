-- CreateEnum
CREATE TYPE "FinanceActions" AS ENUM ('DEPOSIT', 'REPORT');

-- CreateTable
CREATE TABLE "finance_history" (
    "id" SERIAL NOT NULL,
    "value" INTEGER NOT NULL,
    "action" "FinanceActions" NOT NULL,
    "report" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "finance_history_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "finance_history_userId_key" ON "finance_history"("userId");

-- AddForeignKey
ALTER TABLE "finance_history" ADD CONSTRAINT "finance_history_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
