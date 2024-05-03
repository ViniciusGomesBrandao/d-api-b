import { ApiProperty } from "@nestjs/swagger";
import { IsNotEmpty, IsNumber } from "class-validator";

export class CreateFinanceDto {
    @IsNumber()
    @IsNotEmpty()
    @ApiProperty({
        example: 1
    })
    value: number;
}
