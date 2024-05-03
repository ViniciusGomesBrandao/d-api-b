import { ApiProperty } from "@nestjs/swagger";
import { IsNotEmpty, IsNumber } from "class-validator";

export class CreateChatDto {
    @IsNotEmpty({
        message: "Recipient ID cannot be empty."
    })
    @IsNumber({}, {
        message: "Recipient ID must be a number."
    })
    @ApiProperty({
        example: 1,     
        description: "The ID of the recipient for the chat."
    })
    recipient: number;
}