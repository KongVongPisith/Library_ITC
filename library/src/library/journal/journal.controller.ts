/* eslint-disable prettier/prettier */
import { Controller, Get, Post, Body, Patch, Param, Delete, UseInterceptors, UploadedFiles, Res } from '@nestjs/common';
import { JournalService } from './journal.service';
import { Prisma } from '@prisma/client';
import { S3Service } from 'src/aws.service';
import { FileFieldsInterceptor } from '@nestjs/platform-express';
import { Response } from 'express';

@Controller('journal')
export class JournalController {
  constructor(private readonly journalService: JournalService, private readonly aws: S3Service) {}

  @Post()
  @UseInterceptors(FileFieldsInterceptor([{ name: 'cover',maxCount:1}, { name: 'pdf',maxCount:1 }]))
  async create(@Body() createJournal: Prisma.JournalUncheckedCreateInput & { fieldsResearch_Id: number },
    @UploadedFiles() files: { cover?: Express.Multer.File[]; pdf?: Express.Multer.File[] },
    @Res() res: Response
  ) {

    const coverFile = files.cover[0];
    const pdfFile = files.pdf[0];
    console.log(coverFile);
    console.log(pdfFile);
    await this.aws.upload(coverFile);
    await this.aws.uploadPdf(pdfFile);

    await this.journalService.create(createJournal, coverFile, pdfFile);
    return res.redirect('/journalList');
  }

  @Get()
  findAll() {
    return this.journalService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.journalService.findOne(+id);
  }

  @Patch(':id')
  @UseInterceptors(FileFieldsInterceptor([{ name: 'cover', maxCount: 1 }, { name: 'pdf', maxCount: 1 }]))
  async update(@Param('id') id: string, @Body() updateJournal: Prisma.JournalUncheckedUpdateInput & { fieldsResearch_Id: number },
    @UploadedFiles() files: { cover?: Express.Multer.File[]; pdf?: Express.Multer.File[] },
    @Res() res: Response
  ) {

    const coverFile = files.cover[0];
    const pdfFile = files.pdf[0];
    console.log(coverFile);
    console.log(pdfFile);
    await this.aws.upload(coverFile);
    await this.aws.uploadPdf(pdfFile);

    await this.journalService.update(+id, updateJournal, coverFile, pdfFile);
    return res.redirect('/journalList');
  }

  @Delete(':id')
  async remove(@Param('id') id: string, @Res() res: Response) {
    await this.journalService.remove(+id);
    return res.redirect('/journalList');
  }
}
