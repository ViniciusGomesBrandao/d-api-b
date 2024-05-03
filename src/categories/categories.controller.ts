import { Controller, Get, Post, Body, Patch, Param, Delete, Query, Req, UseGuards } from '@nestjs/common';
import { CategoriesService } from './categories.service';
import { CreateCategoryDto } from './dto/create-category.dto';
import { UpdateCategoryDto } from './dto/update-category.dto';
import { SearchCategoryDto } from './dto/search-category.dto';
import { FormDataRequest } from 'nestjs-form-data';
import { AuthGuard } from 'src/auth/auth.guard';
import { ApiBearerAuth, ApiBody, ApiConsumes, ApiOperation, ApiTags } from '@nestjs/swagger';

@Controller('categories')
@ApiTags('Categories')
export class CategoriesController {
  
  constructor(private readonly categoriesService: CategoriesService) {}

  @Post()
  @ApiOperation({ summary: 'Create category' })
  @ApiBearerAuth()
  @UseGuards(AuthGuard)
  @ApiBody({
    type: CreateCategoryDto,
    description: 'Data for creating a new category'
  })
  @ApiConsumes('multipart/form-data')
  @FormDataRequest()
  async create(@Body() createCategoryDto: CreateCategoryDto, @Req() req: any) {
    return await this.categoriesService.create(createCategoryDto, req.user.id);
  }

  @Get()
  @ApiOperation({ summary: 'Get all categories' })
  @ApiBearerAuth()
  @UseGuards(AuthGuard)
  @ApiConsumes('multipart/form-data')
  @FormDataRequest()
  async findAll(@Query() searchFilters: SearchCategoryDto, @Req() req: any) {
    return await this.categoriesService.findAll(searchFilters, req.user.id);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get category by ID' })
  @ApiBearerAuth()
  @UseGuards(AuthGuard)
  @ApiConsumes('multipart/form-data')
  @FormDataRequest()
  async findOne(@Param('id') id: string, @Req() req: any) {
    return await this.categoriesService.findOne(+id, req.user.id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update category' })
  @ApiBearerAuth()
  @UseGuards(AuthGuard)
  @ApiBody({
    type: UpdateCategoryDto,
    description: 'Data for updating a category'
  })
  @ApiConsumes('multipart/form-data')
  @FormDataRequest()
  async update(@Param('id') id: string, @Body() updateCategoryDto: UpdateCategoryDto, @Req() req: any) {
    return this.categoriesService.update(+id, updateCategoryDto, req.user.id);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete category by ID' })
  @ApiBearerAuth()
  @UseGuards(AuthGuard)
  async remove(@Param('id') id: string) {
    return this.categoriesService.remove(+id);
  }
}
