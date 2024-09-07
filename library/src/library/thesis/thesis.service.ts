/* eslint-disable prettier/prettier */
import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { S3Service } from 'src/aws.service';
import { DatabaseService } from 'src/database/database.service';

@Injectable()
export class ThesisService {


  constructor(private readonly db: DatabaseService, private readonly aws: S3Service){}

  async create(create: Prisma.ThesisUncheckedCreateInput & {department_id:number}, cover: Express.Multer.File, pdf:Express.Multer.File) {

    const CoverUrl = `https://${process.env.AWS_S3_BUCKET_NAME}.s3.${process.env.AWS_REGION}.amazonaws.com/${cover.originalname}`;
    create.cover = CoverUrl;

    const PdfUrl = `https://${process.env.AWS_S3_BUCKET_PDF}.s3.${process.env.AWS_REGION}.amazonaws.com/${pdf.originalname}`;
    create.pdf = PdfUrl;

    create.department_id = Number(create.department_id);

    return this.db.thesis.create({data: create});
  }

  findAll() {
    return this.db.thesis.findMany({
      include: {
      department:true
    }});
  }

  findOne(id: number) {
    return this.db.thesis.findUnique(
      {
        where:
        {
          id 
        },
        include: {
          department:true
        }
      })
  }

  update(id: number, updateThesis: Prisma.ThesisUncheckedUpdateInput & { department_id: number }, cover: Express.Multer.File, pdf: Express.Multer.File) {
    
    updateThesis.cover = `https://${process.env.AWS_S3_BUCKET_NAME}.s3.${process.env.AWS_REGION}.amazonaws.com/${cover.originalname}`;
    updateThesis.pdf = `https://${process.env.AWS_S3_BUCKET_PDF}.s3.${process.env.AWS_REGION}.amazonaws.com/${pdf.originalname}`;
    updateThesis.department_id = Number(updateThesis.department_id);

    this.aws.upload(cover);
    this.aws.uploadPdf(pdf);

    return this.db.thesis.update({
      where: {
        id: id,
      },
      data: updateThesis
    });
  }

  async remove(id: number) {
    return await this.db.thesis.delete({where:{id}});
  }
}
