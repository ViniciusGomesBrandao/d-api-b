import { Controller, Get, Post, Body, Patch, Param, Delete, Query, UseGuards } from '@nestjs/common';
import { ModulesService } from './modules.service';
import { CreateModuleDto } from './dto/create-module.dto';
import { UpdateModuleDto } from './dto/update-module.dto';
import { SearchModulesDto } from './dto/search-modules.dto';
import { ApiBearerAuth, ApiBody, ApiConsumes, ApiOperation, ApiTags } from '@nestjs/swagger';
import { FormDataRequest } from 'nestjs-form-data';
import { AuthGuard } from 'src/auth/auth.guard';

@Controller('modules')
@ApiTags('Modules')
export class ModulesController {
  constructor(private readonly modulesService: ModulesService) {}

  @Post()
  @ApiOperation({ summary: 'Create module' })
  @ApiBody({
    type: CreateModuleDto,
    description: 'Data for creating a new module'
  })
  create(@Body() createModuleDto: CreateModuleDto) {
    return this.modulesService.create(createModuleDto);
  }

  @Get()
  @ApiOperation({ summary: 'Get all modules' })
  @ApiBearerAuth()
  @UseGuards(AuthGuard)
  @ApiConsumes('multipart/form-data')
  @FormDataRequest()
  async findAll(@Query() searchFilters: SearchModulesDto) {
    return await this.modulesService.findAll(searchFilters);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get module by ID' })
  @ApiConsumes('multipart/form-data')
  @FormDataRequest()
  findOne(@Param('id') id: string) {
    return this.modulesService.findOne(+id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update module' })
  @ApiBody({
    type: UpdateModuleDto,
    description: 'Data for updating a module'
  })
  update(@Param('id') id: string, @Body() updateModuleDto: UpdateModuleDto) {
    return this.modulesService.update(+id, updateModuleDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete module by ID' })
  remove(@Param('id') id: string) {
    return this.modulesService.remove(+id);
  }
}
