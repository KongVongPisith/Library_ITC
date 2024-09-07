/* eslint-disable prettier/prettier */
import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { DatabaseService } from 'src/database/database.service';
@Injectable()
export class FieldService {

  constructor(private readonly db:DatabaseService){}

  async create(createField: Prisma.FieldsResearchUncheckedCreateInput, cover: Express.Multer.File) {

    const url = `https://${process.env.AWS_S3_BUCKET_NAME}.s3.${process.env.AWS_REGION}.amazonaws.com/${cover.originalname}`;

    createField.cover = url;

    return this.db.fieldsResearch.create({data: createField})
  }

  async findAll() {
    return await this.db.fieldsResearch.findMany({});
  }

  async findOne(id: number) {
    return await this.db.fieldsResearch.findUnique({where:{id}})
  }

  async update(id: number, updateField: Prisma.FieldsResearchUncheckedUpdateInput, cover: Express.Multer.File) {

    const url = `https://${process.env.AWS_S3_BUCKET_NAME}.s3.${process.env.AWS_REGION}.amazonaws.com/${cover.originalname}`;
    updateField.cover = url;

    return await this.db.fieldsResearch.update({
      where: {
        id,
      },
      data: updateField,
    });
  }

  async remove(id: number) {

    await this.db.journal.updateMany({
      where: { fieldsResearch_Id: id },
      data: { fieldsResearch_Id: null }
    });

    return await this.db.fieldsResearch.delete({ where: { id } });
  }
}
