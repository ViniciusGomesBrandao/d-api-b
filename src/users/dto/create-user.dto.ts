import { ApiProperty } from "@nestjs/swagger";
import { Role } from "@prisma/client";
import { IsEmail, IsEnum, IsNotEmpty, IsOptional, IsString } from "class-validator";

export class CreateUserDto {

    @IsNotEmpty()
    @IsEmail()
    @ApiProperty({
        example: "default@gmail.com",
        required: true,
        description: "The email address of the user.",
    })
    email: string;

    @IsNotEmpty()
    @IsString()
    @ApiProperty({
        example: "12345678",
        required: true,
        description: "The password for the user's account."
    })
    password: string;

    @IsOptional()
    @IsString()
    @ApiProperty({
        example: "default",
        required: false,
        description: "The username chosen by the user."
    })
    username: string;

    @IsNotEmpty()
    @IsEnum(Role)
    @ApiProperty({
        example: "ADMIN",
        required: true,
        description: "The role assigned to the user. Possible values are 'ADMIN', 'MANAGER', 'SUPPORT', 'EMPLOYEE' and 'CLIENT'"
    })
    role: Role;
}