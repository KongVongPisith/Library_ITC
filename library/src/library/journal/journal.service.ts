/* eslint-disable prettier/prettier */
import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { DatabaseService } from 'src/database/database.service';

@Injectable()
export class JournalService {

  constructor(private readonly db: DatabaseService){}

  async create(createJournal: Prisma.JournalUncheckedCreateInput & { fieldsResearch_Id: number },
    cover: Express.Multer.File, pdf: Express.Multer.File) {

    const coverUrl = `https://${process.env.AWS_S3_BUCKET_NAME}.s3.${process.env.AWS_REGION}.amazonaws.com/${cover.originalname}`;
    const pdfUrl = `https://${process.env.AWS_S3_BUCKET_PDF}.S3.amazonaws.com/${pdf.originalname}`;

    createJournal.cover = coverUrl;
    createJournal.pdf = pdfUrl;

    createJournal.fieldsResearch_Id = Number(createJournal.fieldsResearch_Id)
    
    return await this.db.journal.create({data: createJournal});
  }

  async findAll() {
    return await this.db.journal.findMany({include:{fieldsResearch:true}});
  }

  async findOne(id: number) {
    return this.db.journal.findUnique({
      where: { id },
      include: {
        fieldsResearch:true
      }
    });
  }

  async update(id: number, updateJournal: Prisma.JournalUncheckedUpdateInput & { fieldsResearch_Id: number },
    cover: Express.Multer.File, pdf: Express.Multer.File) {
    
    const coverUrl = `https://${process.env.AWS_S3_BUCKET_NAME}.s3.${process.env.AWS_REGION}.amazonaws.com/${cover.originalname}`;
    const pdfUrl = `https://${process.env.AWS_S3_BUCKET_PDF}.S3.amazonaws.com/${pdf.originalname}`;

    updateJournal.cover = coverUrl;
    updateJournal.pdf = pdfUrl;

    updateJournal.fieldsResearch_Id = Number(updateJournal.fieldsResearch_Id);
    
    return await this.db.journal.update({
      where: {
        id
      },
      data: updateJournal,
      include: {
        fieldsResearch:true
      }
    });
  }

  remove(id: number) {
    return this.db.journal.delete({where:{id}})
  }
}
