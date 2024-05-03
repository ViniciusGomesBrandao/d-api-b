import { Injectable } from '@nestjs/common';
import { CreateChatDto } from './dto/create-chat.dto';
import { UpdateChatDto } from './dto/update-chat.dto';
import { IOutput } from 'src/_helpers/default-interfaces';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreateMessageDto } from './dto/create-message.dto';
import { GetMessageDto } from './dto/get-messages.dto';

@Injectable()

export class ChatService {

  constructor(
    private prisma: PrismaService
  ) {

  }

  async create(createChatDto: CreateChatDto, userID: number) {
    let output: IOutput;
    try {
      const newChat = await this.prisma.chats.create({
        data: {
          participants: {
            createMany: {
              data: [
                {
                  userId: userID
                },
                {
                  userId: createChatDto.recipient
                }
              ],
              skipDuplicates: true
            }
          }
        }
      });

      output = {
        success: true,
        message: "Chat criado com sucesso!",
        data: newChat
      }
    } catch (error) {
      output = {
        success: false,
        message: error.message,
      }
    }
    return output;
  }

  //Get all open chats
  async findAll(userID: number): Promise<IOutput> {
    let output: IOutput;
    try {
      const allChats = await this.prisma.chats.findMany({
        where: {
          participants: {
            some: {
              userId: userID
            }
          }
        },
        select: {
          id: true,
          status: true,
          created_at: true,
          updated_at: true,
          participants: {
            select: {
              user: {
                select: {
                  id: true,
                  username: true,
                  email: true,
                  role: true,
                  status: true
                }
              }
            }
          },
          messages: {
            take: 10,
            orderBy: {
              created_at: 'desc'
            }
          }
        }
      });
      output = {
        success: true,
        message: "Information consulted successfully!",
        data: allChats
      }
    } catch (error) {
      output = {
        success: false,
        message: error.message
      }
    }
    return output;
  }

  //Get all messages
  async findAllMessages(userID: number, getMessageDto: GetMessageDto) {
    let output: IOutput;
    try {
      const checkParticipant = await this.prisma.chats.findFirstOrThrow({
        where: {
          id: Number(getMessageDto.id_chat),
          participants: {
            some: {
              userId: userID
            }
          }
        },
      }).catch((error) => {
        console.log(error);
        throw new Error("Usuário não pertence ao chat informado");
      });

      const allMessages = await this.prisma.messages.findMany({
        skip: getMessageDto.page ? Number(getMessageDto.page) : 0,
        take: getMessageDto.limit ? Number(getMessageDto.limit) : 10,
        where: {
          chatId: Number(getMessageDto.id_chat)
        }
      });

      output = {
        success: true,
        message: "Mensagens consultadas com sucesso!",
        data: allMessages
      }
      
    } catch (error) {
      output = {
        success: false,
        message: error.message
      }
    }
    return output;
  }

  async createMessage(createMenssageDto: CreateMessageDto, userID: number, files?: any[]) {
    let output: IOutput;
    try {
      const checkParticipant = this.prisma.chats.findFirstOrThrow({
        where: {
          participants: {
            some: {
              userId: userID
            }
          }
        },
      }).catch((error) => {
        console.log(error)
        throw new Error("Usuário não pertence ao chat informado");
      });

      const newMessage = await this.prisma.messages.create({
        data: {
          content: createMenssageDto.message,
          authorId: userID,
          chatId: createMenssageDto.chat_id
        }
      });

      output = {
        success: true,
        message: "Mensagem criada com sucesso!",
        data: newMessage
      }
    } catch (error) {
      output = {
        success: false,
        message: error.message
      }
    }
    return output;
  }

  async findOne(id: number, userID: number) {
    let output: IOutput;
    try {
        const chatDetail = await this.prisma.chats.findFirstOrThrow({
          where: {
            id: id,
            participants: {
              some: {
                userId: userID
              }
            }
          }
        }).catch((error) => {
          console.log(error)
          throw new Error("Usuário não pertence ao chat informado");
        });

        output = {
          success: true,
          message: "Chat consultado com sucesso!",
          data: chatDetail
        }
    } catch (error) {
      output = {
        success: false,
        message: error.message
      }
    }
    return output;
  }
}
