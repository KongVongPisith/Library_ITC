/* eslint-disable prettier/prettier */
import { Controller, Get, Post, Body, Patch, Param, Delete, UseInterceptors, UploadedFiles, Res } from '@nestjs/common';
import { ThesisService } from './thesis.service';
import { Prisma } from '@prisma/client';
import { FileFieldsInterceptor } from '@nestjs/platform-express';
import { S3Service } from 'src/aws.service';
import { Response } from 'express';

@Controller('thesis')
export class ThesisController {
  constructor(private readonly thesisService: ThesisService,private readonly aws: S3Service) { }
  
  @Post()
  @UseInterceptors(FileFieldsInterceptor(
    [
      { name: 'cover', maxCount: 1 }, { name: 'pdf', maxCount: 1 }
    ]
  ))
  async create(@Body() createThesis: Prisma.ThesisCreateInput &{department_id:number},
    @UploadedFiles() files: {
      cover?: Express.Multer.File[]; pdf?: Express.Multer.File[]
    }, @Res() res: Response
  ) {
    
    console.log(files.cover[0]);
    console.log(files.pdf[0]);
    
    await this.aws.upload(files.cover[0]);
    await this.aws.uploadPdf(files.pdf[0]);

    await this.thesisService.create(createThesis, files.cover[0], files.pdf[0]);
    return res.redirect('/thesisList')
  }

  @Get()
  findAll() {
    return this.thesisService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.thesisService.findOne(+id);
  }

  @Patch(':id')
  @UseInterceptors(
      FileFieldsInterceptor([{ name: 'cover', maxCount: 1 }, { name: 'pdf', maxCount: 1 }])
  )
  async update(@Param('id') id: string,
    @Body() updateThesis: Prisma.ThesisUncheckedUpdateInput &{department_id:number},
    @UploadedFiles() files: { cover?: Express.Multer.File[]; pdf?: Express.Multer.File[] },
    @Res() res:Response
  ) {
    await this.thesisService.update(+id, updateThesis, files.cover[0], files.pdf[0]);
    return res.redirect('/thesisList')
  }

  @Delete(':id')
  async remove(@Param('id') id: string, @Res() res: Response) {
    await this.thesisService.remove(+id);
    return res.redirect('/thesisList')
  }
}
