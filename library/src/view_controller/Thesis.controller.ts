/* eslint-disable prettier/prettier */
import { Controller, Get, Param, Render, Res } from "@nestjs/common";
import { Response } from 'express';
import { DatabaseService } from "src/database/database.service";

@Controller()
export class ThesisViewController {
    constructor(private prisma: DatabaseService) { }
    
    
    @Get('/thesisInput')
    @Render('thesis/thesis.ejs')
  async getThesis() {
    const departments = await this.prisma.department.findMany();
    return { departments };
  }

  @Get('thesisList')
  @Render('thesis/thesisList.ejs')
  async getTheses(@Res() res: Response) {
    const theses = await this.prisma.thesis.findMany({
      include: { department: true }
    });
    const messages = res.locals.flash;
    return { theses, messages };
  }

  @Get('/thesis/:id/update')
  @Render('thesis/thesisUpdate.ejs')
  async editThesis(@Param('id') id: string) {
    const thesis = await this.prisma.thesis.findUnique({
      where: { id: Number(id) },
      include: { department: true },
    });
    const departments = await this.prisma.department.findMany();
    return {
      title: 'Edit',
      thesis,
      departments,
    };
  }

  @Get('/department')
  @Render('thesis/department.ejs')
  async getDepartment() { }

  @Get('/departmentList')
  @Render('thesis/departmentList.ejs')
  async getDepartmentList(@Res() res: Response) {
    const departments = await this.prisma.department.findMany({})
    const messages = res.locals.flash;
    return { departments, messages };
  }

  @Get('/department/:id/update')
  @Render('thesis/departmentUpdate.ejs')
  async editDepartment(@Param('id') id: string) {
    const department = await this.prisma.department.findUnique({
      where: { id: Number(id) }
    });
    return {
      title: 'Edit',
      department,
    };
  }
}