/* eslint-disable prettier/prettier */
import { Injectable } from '@nestjs/common';
import { DatabaseService } from '../../database/database.service';
import { Prisma } from '@prisma/client';

@Injectable()
export class NewsletterService {

  constructor(private readonly db: DatabaseService){}

  async create(createNewsletter: Prisma.NewpaperUncheckedCreateInput, file: Express.Multer.File) {

    const url = `https://${process.env.AWS_S3_BUCKET_PDF}.s3.${process.env.AWS_REGION}.amazonaws.com/${file.originalname}`;
    createNewsletter.pdf = url;
    return await this.db.newpaper.create({data: createNewsletter});
  }

  async findAll() {
    return await this.db.newpaper.findMany({}); 
  }

  async findOne(id: number) {
    return await this.db.newpaper.findUnique({
      where: {
        id,
      }
    }
    );
  }

  async update(id: number, updateNewsletter: Prisma.NewpaperUncheckedUpdateInput, file: Express.Multer.File) {
    const url = `https://${process.env.AWS_S3_BUCKET_PDF}.s3.${process.env.AWS_REGION}.amazonaws.com/${file.originalname}`;
    updateNewsletter.pdf = url;
    return await this.db.newpaper.update({
      where: {
        id,
      },
      data: updateNewsletter
    });
  }

  async remove(id: number) {
    return await this.db.newpaper.delete({
      where: {
        id,
      }
    });
  }
}
