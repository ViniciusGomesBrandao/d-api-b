import { ApiProperty } from "@nestjs/swagger";
import { IsArray, IsNotEmpty, IsNumber, IsOptional, IsString, Validate, ValidateNested } from "class-validator";

export class CreateMessageDto {
    @IsNotEmpty({
        message: "Chat ID cannot be empty."
    })
    @IsNumber({}, {
        message: "Chat ID must be a number."
    })
    @ApiProperty({
        example: 1,
        description: "The ID of the chat to which the message belongs."
    })
    chat_id: number;

    @IsNotEmpty({
        message: "Message content cannot be empty."
    })
    @IsString({
        message: "Message content must be a string."
    })
    @ApiProperty({
        example: "TEST MESSAGE",
        description: "The content of the message."
    })
    message: string;

    @IsOptional()
    @ApiProperty({
        type: 'array',
        items: {
            type: 'file',
            format: 'binary'
        },
        description: "An array containing file attachments for the message."
    })
    @IsArray({
        message: "Files must be provided as an array."
    })
    @ValidateNested({
        each: true
    })
    files?: any[];
}
