/* eslint-disable prettier/prettier */
import { Controller, Get, Post, Body, Patch, Param, Delete, UseInterceptors, UploadedFile, Res } from '@nestjs/common';
import { CategoryService } from './category.service';
import { S3Service } from 'src/aws.service';
import { Prisma } from '@prisma/client';
import { FileInterceptor } from '@nestjs/platform-express';
import { Response } from 'express';

@Controller('category')
export class CategoryController {
  constructor(private readonly categoryService: CategoryService,private readonly aws: S3Service) {}

  @Post()
  @UseInterceptors(FileInterceptor('cover'))
  async create(@Body() createCategory: Prisma.CategoryCreateInput, @UploadedFile() cover: Express.Multer.File,@Res() res:Response) {
    await this.aws.upload(cover)
    await this.categoryService.create(createCategory, cover);
    return res.redirect('/categoryList')
  }

  @Get()
  findAll() {
    return this.categoryService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.categoryService.findOne(+id);
  }

  @Patch(':id')
  @UseInterceptors(FileInterceptor('cover'))
  async update(
    @Param('id') id: string,
    @Body() updateCategory: Prisma.CategoryUncheckedUpdateInput,
    @UploadedFile() cover: Express.Multer.File,
    @Res() res: Response
  ) {
    if ('_method' in updateCategory) {
      delete updateCategory['_method'];
    }
    await this.aws.upload(cover)
    await this.categoryService.update(+id, updateCategory, cover);
    return res.redirect('/categoryList')
  }

  @Delete(':id')
  async remove(@Param('id') id: string, @Res() res: Response) {
    await this.categoryService.remove(+id);
    return res.redirect('/categoryList')
  }
}
