/* eslint-disable prettier/prettier */
import { Controller, Get, Param, Render, Res } from "@nestjs/common";
import { DatabaseService } from "src/database/database.service";
import { Response } from 'express';


@Controller()
export class BookViewController {
    constructor(private readonly prisma: DatabaseService) { }
    
    @Get('/bookInput')
  @Render('book/book.ejs')
  async getRender() {
     const categories = await this.prisma.category.findMany();
    return { categories };
  }

  @Get('/bookList')
  @Render('book/bookList')
  async getBooks(@Res() res: Response) {
    const messages = res.locals.flash;
    const books = await this.prisma.book.findMany({
      include: { category: true }
    });
    return { books,messages };
  }
  
  @Get('/book/:id/update')
  @Render('book/bookUpdate.ejs')
  async editBook(@Param('id') id: string) {
    const book = await this.prisma.book.findUnique({
      where: { id:Number(id) }
    });
    const categories = await this.prisma.category.findMany();
    return {
      title: 'Edit',
      book,
      categories
    };
  }

  @Get('/bookCategory')
  @Render('book/category.ejs')
  async getCategory() { }
  
  @Get('/categoryList')
  @Render('book/categoryList.ejs')
  async getCategoryList(@Res() res: Response) {
    const categories = await this.prisma.category.findMany({})
    const messages = res.locals.flash;
    return { categories, messages };
  }
  
  @Get('/category/:id/update')
  @Render('book/categoryUpdate.ejs')
  async editCategory(@Param('id') id: string) {
    const category = await this.prisma.category.findUnique({
      where: { id: Number(id) }
    });
    return {
      title: 'Edit',
      category,
    };
  }
}