/* eslint-disable prettier/prettier */
import { Controller, Get, Post, Body, Patch, Param, Delete, UseInterceptors, UploadedFile, Res } from '@nestjs/common';
import { FieldService } from './field.service';
import { S3Service } from 'src/aws.service';
import { Prisma } from '@prisma/client';
import { FileInterceptor } from '@nestjs/platform-express';
import { Response } from 'express';

@Controller('field')
export class FieldController {
  constructor(private readonly fieldService: FieldService, private readonly aws: S3Service) {}

  @Post()
  @UseInterceptors(FileInterceptor('cover'))
  async create(@Body() createField: Prisma.FieldsResearchUncheckedCreateInput, @UploadedFile() cover: Express.Multer.File,
    @Res() res: Response) {

    await this.aws.upload(cover);

    await this.fieldService.create(createField, cover);
    return res.redirect('/fieldList');
  }

  @Get()
  findAll() {
    return this.fieldService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.fieldService.findOne(+id);
  }

  @Patch(':id')
  @UseInterceptors(FileInterceptor('cover'))
  async update(
    @Param('id') id: string,
    @Body() updateField: Prisma.FieldsResearchUncheckedUpdateInput,
    @UploadedFile() cover: Express.Multer.File,
    @Res() res: Response
  ) {
    
    if ('_method' in updateField) {
      delete updateField['_method'];
    }
    
    await this.aws.upload(cover);
    await this.fieldService.update(+id, updateField, cover);
    return res.redirect('/fieldList')
  }

  @Delete(':id')
  async remove(@Param('id') id: string, @Res() res: Response) {
    await this.fieldService.remove(+id);
    return res.redirect('/fieldList')
  }
}
