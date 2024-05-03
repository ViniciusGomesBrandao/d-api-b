import { ApiProperty } from "@nestjs/swagger";
import { IsArray, IsNotEmpty, IsNumber, IsNumberString, IsString, Validate } from "class-validator";
import { PaginationDto } from "src/_helpers/pagination.dto";

export class GetMessageDto extends PaginationDto {
    @IsNotEmpty()
    @IsNumberString()
    @ApiProperty({
        example: 1
    })
    id_chat: number;
}
