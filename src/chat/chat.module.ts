import { Module } from '@nestjs/common';
import { ChatService } from './chat.service';
import { ChatController } from './chat.controller';
import { PrismaService } from 'src/prisma/prisma.service';
import { JwtService } from '@nestjs/jwt';

@Module({
  imports: [
  ],
  controllers: [ChatController],
  providers: [ChatService, PrismaService, JwtService]
})
export class ChatModule {}
