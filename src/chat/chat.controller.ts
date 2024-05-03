import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Req, Request, UploadedFiles, UseInterceptors, Query } from '@nestjs/common';
import { ChatService } from './chat.service';
import { CreateChatDto } from './dto/create-chat.dto';
import { UpdateChatDto } from './dto/update-chat.dto';

import { ApiBearerAuth, ApiBody, ApiConsumes, ApiOperation, ApiProperty, ApiQuery, ApiTags } from '@nestjs/swagger';
import { FormDataRequest } from 'nestjs-form-data';
import { AuthGuard } from 'src/auth/auth.guard';
import { CreateMessageDto } from './dto/create-message.dto';
import { FilesInterceptor } from '@nestjs/platform-express';
import { GetMessageDto } from './dto/get-messages.dto';

@ApiTags('Chat')
@Controller('chat')
export class ChatController {
  constructor(private readonly chatService: ChatService) {}

  @Post()
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Create a chat'})
  @ApiBearerAuth()
  @ApiBody({
    type: CreateChatDto
  })
  create(@Body() createChatDto: CreateChatDto, @Request() req: any) {
    return this.chatService.create(createChatDto, req.user.id);
  }

  @Post('message')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Create a new message'})
  @ApiBearerAuth()
  @UseInterceptors(FilesInterceptor('files'))
  @ApiBody({
    type: CreateMessageDto
  })
  createMessage(@Body() createMessage: CreateMessageDto, @Request() req: any, @UploadedFiles() files?: any[]) {
    return this.chatService.createMessage(createMessage, req.user.id, files);
  }

  @Get()
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Get open chats'})
  @ApiBearerAuth()
  async findAll(@Req() req: any) {
    return await this.chatService.findAll(req.user.id);
  }

  @Get("message")
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Get messages from a chat'})
  @ApiBearerAuth()
  async findAllMessages(@Req() req: any, @Query() getMessageDto: GetMessageDto) {
    return await this.chatService.findAllMessages(req.user.id, getMessageDto);
  }

  @Get(':id')
  @UseGuards(AuthGuard)
  @ApiOperation({
    summary: "Get details of a chat"
  })
  @ApiBearerAuth()
  async findOne(@Param('id') id: string, @Req() req: any) {
    return await this.chatService.findOne(+id, req.user.id);
  }
}
