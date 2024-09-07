/* eslint-disable prettier/prettier */
import { Controller, Get, Post, Body, Patch, Param, Delete, UseInterceptors, UploadedFile, Res } from '@nestjs/common';
import { NewsletterService } from './newsletter.service';
import { S3Service } from 'src/aws.service';
import { Prisma } from '@prisma/client';
import { FileInterceptor } from '@nestjs/platform-express';
import { Response } from 'express';

@Controller('newsletter')
export class NewsletterController {
  constructor(private readonly newsletterService: NewsletterService, private readonly S3: S3Service) {}

  @UseInterceptors(FileInterceptor('file'))
  @Post()
  async create(@Body() createNewsletter: Prisma.NewpaperCreateInput, @UploadedFile() file: Express.Multer.File,@Res() res: Response) {
    await this.S3.uploadPdf(file);
    await this.newsletterService.create(createNewsletter, file);
    return res.redirect('/newslettersList')
  }

  @Get()
  findAll() {
    return this.newsletterService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.newsletterService.findOne(+id);
  }

  @UseInterceptors(FileInterceptor('file'))
  @Patch(':id')
  async update(@Param('id') id: string, @Body() updateNewsletter: Prisma.NewpaperUncheckedUpdateInput, @UploadedFile() file: Express.Multer.File,
  @Res() res: Response
  ) {

    if ('_method' in updateNewsletter) {
      delete updateNewsletter['_method'];
     }

    await this.S3.uploadPdf(file);

    await this.newsletterService.update(+id, updateNewsletter, file);
    return res.redirect('/newslettersList')
  }

  @Delete(':id')
  async remove(@Param('id') id: string, @Res() res: Response) {
    await this.newsletterService.remove(+id);
    return res.redirect('/newslettersList');
  }
}
