import { Injectable } from '@nestjs/common';
import { CreateFinanceDto } from './dto/create-finance.dto';
import { UpdateFinanceDto } from './dto/update-finance.dto';
import { IOutput } from 'src/_helpers/default-interfaces';
import { PrismaService } from 'src/prisma/prisma.service';
import { GetAllFinanceDto } from './dto/get-all-finance.dto';
import { GetSummaryDto } from './dto/get-summary.dto';

@Injectable()
export class FinanceService {

  constructor(
    private prisma: PrismaService
  ) {

  }
  async create(createFinanceDto: CreateFinanceDto, userID: number) {

    let output: IOutput;
    try {
      const updateFinance = await this.prisma.finances.update({
        where: {
          userId: userID
        },
        data: {
          balance: {
            increment: createFinanceDto.value
          }
        },
        select: {
          id: true,
          userId: true,
          balance: true,
          debit: true,
          created_at: true,
          updated_at: true
        }
      }).catch((error) => { throw new Error("Error when updating user") });

      // ADDIGN TO HISTORY
      await this.prisma.finance_history.create({
        data: {
          action: "DEPOSIT",
          value: createFinanceDto.value,
          userId: userID
        }
      }).catch((error) => { console.log(error) })

      output = {
        success: true,
        message: "Deposit made successfuly!",
        data: updateFinance
      }
    } catch (error) {
      output = {
        success: true,
        message: error.message
      }
    }
    return output;
  }

  async findAll(params: GetAllFinanceDto, userID: number) {
    let output: IOutput
    try {
      const allFinanceRecords = await this.prisma.finance_history.findMany({
        skip: params.page ? Number(params.page) : 0,
        take: params.limit ? Number(params.limit) : 10,
        where: {
          userId: userID
        }
      });
      output = {
        success: true,
        message: "financial records consulted successfully!",
        data: allFinanceRecords
      }
    } catch (error) {
      output = {
        success: false,
        message: error.message
      }
    }
    return output;
  }

  async summary(params: GetSummaryDto, userID: number) {
    let output: IOutput;
    try {

      let summary: {
        reports: any,
        finance: any
      } = {
        reports: {},
        finance: {}
      };

      //Create variable for one yaer ago
      const oneYearAgo = new Date();
      oneYearAgo.setFullYear(oneYearAgo.getFullYear() - 1);


      const reportHistory = await this.prisma.report_history.findMany({
        where: {
          userId: userID,
          created_at: {
            gte: oneYearAgo
          }
        }
      });

      const financeHistory = await this.prisma.finance_history.findMany({
        where: {
          userId: userID,
          created_at: {
            gte: oneYearAgo
          }
        }
      });
      console.log(financeHistory);

      
      for (const record of reportHistory) {
        const createdAt = new Date(record.created_at);
        const formattedDate = `${(createdAt.getMonth() + 1).toString().padStart(2, '0')}-${createdAt.getDate().toString().padStart(2, '0')}-${createdAt.getFullYear()}`;
        if (!summary.reports[formattedDate]) {
          summary.reports[formattedDate] = [];
        }
        summary.reports[formattedDate].push(record);
      }

      for (const record of financeHistory){
        const createdAt = new Date(record.created_at);
        const formattedDate = `${(createdAt.getMonth() + 1).toString().padStart(2, '0')}-${createdAt.getDate().toString().padStart(2, '0')}-${createdAt.getFullYear()}`;
        if (!summary.finance[formattedDate]) {
          summary.finance[formattedDate] = 0;
        }
        summary.finance[formattedDate] += record.value;
      }



      output = {
        success: true,
        message: "Financial summary consulted successfully!",
        data: summary
      }
    } catch (error) {
      output = {
        success: false,
        message: error.message
      }
    }
    return output;
  }

  findOne(id: number) {
    return `This action returns a #${id} finance`;
  }

  update(id: number, updateFinanceDto: UpdateFinanceDto) {
    return `This action updates a #${id} finance`;
  }

  remove(id: number) {
    return `This action removes a #${id} finance`;
  }
}
