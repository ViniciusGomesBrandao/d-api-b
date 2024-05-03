import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Request, Query } from '@nestjs/common';
import { FinanceService } from './finance.service';
import { CreateFinanceDto } from './dto/create-finance.dto';
import { UpdateFinanceDto } from './dto/update-finance.dto';
import { ApiBearerAuth, ApiOperation, ApiTags } from '@nestjs/swagger';
import { AuthGuard } from 'src/auth/auth.guard';
import { GetAllFinanceDto } from './dto/get-all-finance.dto';
import { GetSummaryDto } from './dto/get-summary.dto';

@ApiTags('Finance')
@Controller('finance')
export class FinanceController {
  constructor(private readonly financeService: FinanceService) {}

  @Post('deposit')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Make deposit'})
  @ApiBearerAuth()
  create(@Body() createFinanceDto: CreateFinanceDto, @Request() req: any) {
    return this.financeService.create(createFinanceDto, req.user.id);
  }

  @Get()
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Get all financial registers'})
  @ApiBearerAuth()
  findAll(@Query() params: GetAllFinanceDto, @Request() req: any) {
    return this.financeService.findAll(params, req.user.id);
  }

  @Get('summary')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Get financial summary'})
  @ApiBearerAuth()
  summary(@Query() params: GetSummaryDto, @Request() req: any) {
    return this.financeService.summary(params, req.user.id);
  }
}