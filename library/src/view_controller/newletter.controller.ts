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
export class NewsletterViewController {
    constructor(private prisma: DatabaseService) { }
    
    @Get('/newsletterInput')
  @Render('newsletter/newslettersInput.ejs')
  async getNewsletters() { }

  @Get('/newslettersList')
  @Render('newsletter/newslettersList.ejs')
  async getNewsletterList(@Res() res: Response) {
    const newsletters = await this.prisma.newpaper.findMany({})
    const messages = res.locals.flash;
    return { newsletters, messages };
  }

  @Get('/newsletter/:id/update')
  @Render('newsletter/newslettersUpdate.ejs')
  async editNewsletter(@Param('id') id: string) {
    const newsletter = await this.prisma.newpaper.findUnique({
      where: { id: Number(id) }
    });
    return {
      title: 'Edit',
      newsletter
    };
  }


}