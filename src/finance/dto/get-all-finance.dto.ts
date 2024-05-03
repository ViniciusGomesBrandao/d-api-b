import { ApiProperty } from "@nestjs/swagger";
import { IsNotEmpty, IsNumber } from "class-validator";
import { PaginationDto } from "src/_helpers/pagination.dto";

export class GetAllFinanceDto extends PaginationDto {

}
