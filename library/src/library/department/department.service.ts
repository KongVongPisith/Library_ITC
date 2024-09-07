/* eslint-disable prettier/prettier */
import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { S3Service } from 'src/aws.service';
import { DatabaseService } from 'src/database/database.service';

@Injectable()
export class DepartmentService {

  constructor(private readonly db: DatabaseService,private readonly aws:S3Service){}

  async create(createDepartment: Prisma.DepartmentCreateInput, cover: Express.Multer.File) {
    await this.aws.upload(cover);
    const url = `https://${process.env.AWS_S3_BUCKET_NAME}.s3.${process.env.AWS_REGION}.amazonaws.com/${cover.originalname}`;
    createDepartment.cover = url;
    return await this.db.department.create({data:createDepartment});
  }

  findAll() {
    return this.db.department.findMany({});
  }

  findOne(id: number) {
    return this.db.department.findUnique({where:{id}})
  }

  async update(id: number, updateDepartment: Prisma.DepartmentUncheckedUpdateInput, cover: Express.Multer.File) {
    await this.aws.upload(cover);
    const url = `https://${process.env.AWS_S3_BUCKET_NAME}.s3.${process.env.AWS_REGION}.amazonaws.com/${cover.originalname}`;
    updateDepartment.cover = url;
    return this.db.department.update({where:{id},data:updateDepartment})
  }

  async remove(id: number) {

    await this.db.thesis.updateMany({
      where: { department_id: id },
      data: { department_id: null },
    });
    return this.db.department.delete({where:{id}})
  }
}
