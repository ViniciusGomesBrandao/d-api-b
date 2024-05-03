-- DropForeignKey
ALTER TABLE "users_on_chats" DROP CONSTRAINT "users_on_chats_chatId_fkey";

-- AddForeignKey
ALTER TABLE "users_on_chats" ADD CONSTRAINT "users_on_chats_chatId_fkey" FOREIGN KEY ("chatId") REFERENCES "chats"("id") ON DELETE CASCADE ON UPDATE CASCADE;
