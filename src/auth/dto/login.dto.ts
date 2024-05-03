import { ApiProperty } from "@nestjs/swagger";
import { IsEmail, IsNotEmpty, Matches } from "class-validator";

export class LoginDto {

    @IsEmail()
    @ApiProperty({
        description: "The email address of the user."
    })
    @IsNotEmpty({
        message: "Email cannot be empty."
    })
    email: string;

    @IsNotEmpty({
        message: "Password cannot be empty."
    })
    @ApiProperty({
        description: "The password associated with the user's account."
    })
    password: string;

}