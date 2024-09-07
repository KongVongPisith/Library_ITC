/* eslint-disable prettier/prettier */
import {
  Controller,
  Get,
  Param,
  Render,
  Res,
} from '@nestjs/common';
import { Response } from 'express';
import { DatabaseService } from 'src/database/database.service';

@Controller()
export class JournalViewController {

    constructor(private readonly prisma: DatabaseService){}

    @Get('/journalInput')
  @Render('journal/journalInput.ejs')
  async getJournals() {
    const fields = await this.prisma.fieldsResearch.findMany();
    return { fields };
   }

  @Get('/journalList')
  @Render('journal/journalList.ejs')
  async getJournalList(@Res() res: Response) {
    const journals = await this.prisma.journal.findMany({
      include:{fieldsResearch:true},
    })
    const messages = res.locals.flash;
    return { journals, messages };
  }

  @Get('/journal/:id/update')
  @Render('journal/journalUpdate.ejs')
  async editJournal(@Param('id') id: string) {
    const journal = await this.prisma.journal.findUnique({
      where: { id: Number(id) },
      include: {
        fieldsResearch:true
      }
    });
    const fields =await this.prisma.fieldsResearch.findMany({});
    return {
      title: 'Edit',
      journal,
      fields
    };
  }

  @Get('/fieldInput')
  @Render('journal/fieldInput.ejs')
  async getField() { }

  @Get('/fieldList')
  @Render('journal/fieldList.ejs')
  async getFieldList(@Res() res: Response) {
    const fields = await this.prisma.fieldsResearch.findMany({})
    const messages = res.locals.flash;
    return { fields, messages };
  }

  @Get('/field/:id/update')
  @Render('journal/fieldUpdate.ejs')
  async editField(@Param('id') id: string) {
    const field = await this.prisma.fieldsResearch.findUnique({
      where: { id: Number(id) }
    });
    return {
      title: 'Edit',
      field
    };
  }

}