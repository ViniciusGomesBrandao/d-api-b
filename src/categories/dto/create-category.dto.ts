import { ApiProperty } from "@nestjs/swagger";
import { IsArray, IsNotEmpty, IsNumber, IsOptional, IsString } from "class-validator";

export class CreateCategoryDto {
    @IsNotEmpty()
    @IsString()
    @ApiProperty({
        example: "Test Category",
        required: true,
        description: "The name of the category."
    })
    name: string;

    @IsNotEmpty()
    @IsString()
    @ApiProperty({
        example: "Category intended for testing purposes.",
        required: true,
        description: "The description of the category."
    })
    description: string;

    @IsOptional()
    @IsNumber()
    @ApiProperty({
        example: 1.90,
        required: true,
        description: "A custom value associated with the category."
    })
    custom_value: number;

    @IsArray()
    @ApiProperty({
        example: [1, 2],
        required: false,
        description: "An array containing the IDs of the modules to be added to the category."
    })
    modules?: number[];
}
