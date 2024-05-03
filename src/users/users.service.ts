import { Injectable } from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { PrismaService } from 'src/prisma/prisma.service';
import { IOutput } from 'src/_helpers/default-interfaces';
import * as bcrypt from 'bcrypt';
@Injectable()
export class UsersService {

  constructor(
    private prisma: PrismaService
  ) {

  }

  async create(createUserDto: CreateUserDto): Promise<IOutput> {
    let output: IOutput;
    try {
      const existingUser = await this.prisma.users.findFirst({
        where: {
          OR: [
            {
              email: createUserDto.email
            },
            {
              username: createUserDto.username
            }
          ]
        }
      });
      if(existingUser){
        throw new Error("User with an existing username or email");
      }
      const password = await bcrypt.hash(createUserDto.password, 10)
      const newUser = await this.prisma.users.create({
        data: {
          email: createUserDto.email,
          role: createUserDto.role,
          password: password,
          username: createUserDto.username,
          finance: {
            create: {
              balance: 0.0,
              debit: 0.0,
            }
          }
        },
        select: {
          id: true,
          email: true,
          username: true,
          email_status: true,
          id_user: true,
          role: true,
          status: true,
        }
      });
      output = {
        success: true,
        message: "User created successfuly!",
        data: newUser
      }
    } catch (error) {
      output = {
        success: false,
        message: error.message
      }
    }
    return output;
  }

  findAll() {
    return `This action returns all users`;
  }

  findOne(id: number) {
    return `This action returns a #${id} user`;
  }

  update(id: number, updateUserDto: UpdateUserDto) {
    return `This action updates a #${id} user`;
  }

  remove(id: number) {
    return `This action removes a #${id} user`;
  }
}
