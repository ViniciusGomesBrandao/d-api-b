-- CreateEnum
CREATE TYPE "StatusChat" AS ENUM ('ACTIVE', 'INACTIVE', 'ARCHIVED', 'BLOCKED', 'REMOVED');

-- AlterTable
ALTER TABLE "chats" ADD COLUMN     "status" "StatusChat" NOT NULL DEFAULT 'ACTIVE';
