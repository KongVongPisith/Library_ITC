/* eslint-disable prettier/prettier */
import { Controller, Get, Post, Body, Patch, Param, Delete, UseInterceptors, UploadedFiles, BadRequestException, Res } from '@nestjs/common';
import { BookService } from './book.service';
import { Prisma } from '@prisma/client';
import { FileFieldsInterceptor } from '@nestjs/platform-express';
import { S3Service } from 'src/aws.service';
import { Response } from 'express';

@Controller('book')
export class BookController {

  constructor(private readonly bookService: BookService,private readonly aws: S3Service) { }

  @Post()
  @UseInterceptors(
      FileFieldsInterceptor([{ name: 'image', maxCount: 1 }, { name: 'pdf', maxCount: 1 }])
  )
  async create(
    @Body() createBook: Prisma.BookUncheckedCreateInput & {category_id:number},
    @UploadedFiles() files: { image?: Express.Multer.File[]; pdf?: Express.Multer.File[] },
    @Res() res: Response
  ) {
    const imageFile = files.image[0];
    const pdfFile = files.pdf[0];
    console.log(imageFile);
    console.log(pdfFile);
    await this.aws.upload(imageFile);
    await this.aws.uploadPdf(pdfFile);
    try {
      await this.bookService.create(createBook, imageFile, pdfFile);
      return res.redirect('/bookList')
    } catch (error) {
      throw new BadRequestException('Failed to upload files');
    }
  }

  @Get()
  findAll() {
    return this.bookService.findAll();
  }

  
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.bookService.findOne(+id);
  }

  @Patch(':id')
  @UseInterceptors(
      FileFieldsInterceptor([{ name: 'image', maxCount: 1 }, { name: 'pdf', maxCount: 1 }])
  )
  async update(@Param('id') id: string,
    @Body() updateBook: Prisma.BookUncheckedUpdateInput & {category_id:number},
    @UploadedFiles() files: {
      image?: Express.Multer.File[]; pdf?: Express.Multer.File[]
    },
    @Res() res: Response
  ) {
    await this.bookService.update(+id, updateBook, files.image[0], files.pdf[0]);
    return res.redirect('/bookList')
  }

  @Delete(':id')
  async remove(@Param('id') id: string, @Res() res: Response) {
    await this.bookService.remove(+id);
    return res.redirect('/bookList');
  }

}

