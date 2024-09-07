/* eslint-disable prettier/prettier */
import { Controller, Get, Post, Body, Patch, Param, Delete, UseInterceptors, UploadedFile, Res } from '@nestjs/common';
import { DepartmentService } from './department.service';
import { Prisma } from '@prisma/client';
import { FileInterceptor } from '@nestjs/platform-express';
import { Response } from 'express';

@Controller('department')
export class DepartmentController {
  constructor(private readonly departmentService: DepartmentService) { }
  
  @Post()
  @UseInterceptors(FileInterceptor('cover'))
  async create(
    @Body() createDepartment: Prisma.DepartmentCreateInput,
    @UploadedFile() cover: Express.Multer.File,
    @Res() res:Response
  ) {
    await this.departmentService.create(createDepartment, cover);
    return res.redirect('/departmentList');
  }

  @Get()
  findAll() {
    return this.departmentService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.departmentService.findOne(+id);
  }

  @Patch(':id')
  @UseInterceptors(FileInterceptor('cover'))
  async update(
    @Param('id') id: string,
    @Body() updateDepartment: Prisma.DepartmentUncheckedUpdateInput,
    @UploadedFile() cover: Express.Multer.File,
    @Res() res: Response
  ) {
    if ('_method' in updateDepartment) {
      delete updateDepartment['_method'];
    }
    await this.departmentService.update(+id, updateDepartment, cover);
    return res.redirect('/departmentList');
  }

  @Delete(':id')
  async remove(@Param('id') id: string, @Res() res: Response) {
    await this.departmentService.remove(+id);
    return res.redirect('/departmentList');
  }
}
