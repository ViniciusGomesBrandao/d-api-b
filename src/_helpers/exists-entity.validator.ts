import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { ValidationArguments, ValidatorConstraint, ValidatorConstraintInterface } from 'class-validator';

@Injectable()
@ValidatorConstraint({ name: 'EntityExists', async: true })
export class EntityExists implements ValidatorConstraintInterface {

  constructor(private prisma: PrismaService) {}

  async validate(value: any, validationArguments?: ValidationArguments): Promise<boolean> {
    const entity = validationArguments.constraints[0];
    const idField = validationArguments.constraints[1];

    // Verifica se os parâmetros necessários foram fornecidos corretamente
    if (!entity || !idField) {
      throw new Error('Parâmetros inválidos para validação');
    }

    // Consulta o banco de dados para encontrar a entidade com o ID fornecido
    const result = await this.prisma.chats.findUnique({
      where: {
        id: value
      }
    });

    // Se a entidade não existir, lançar uma exceção NotFoundException
    if (!result) {
      throw new NotFoundException(`A ${entity} com o ID ${value} não foi encontrada`);
    }

    // Retorna true se a entidade com o ID fornecido existir
    return true;
  }

  defaultMessage(validationArguments?: ValidationArguments): string {
    const { entity } = validationArguments.constraints[0];
    return `O ${entity} com o ID fornecido não existe no banco de dados`;
  }

}