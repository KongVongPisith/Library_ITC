/* eslint-disable prettier/prettier */
import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { DatabaseService } from 'src/database/database.service';


@Injectable()
export class CategoryService {


  constructor(private readonly db: DatabaseService) {}

  async create(createCategory: Prisma.CategoryCreateInput, cover: Express.Multer.File) {

    const url = `https://${process.env.AWS_S3_BUCKET_NAME}.s3.${process.env.AWS_REGION}.amazonaws.com/${cover.originalname}`;

    createCategory.cover = url;

    return await this.db.category.create({ data: createCategory });
  }

  findAll() {
    return this.db.category.findMany({});
  }

  findOne(id: number) {
    return this.db.category.findUnique({
      where: {
        id,
      }
    }
    );
  }

  async update(id: number, updateCategory: Prisma.CategoryUncheckedUpdateInput, cover: Express.Multer.File) {
    const url = `https://${process.env.AWS_S3_BUCKET_NAME}.s3.${process.env.AWS_REGION}.amazonaws.com/${cover.originalname}`;
    updateCategory.cover = url;
    return await this.db.category.update({
      where: {
      id,
      },
      data: updateCategory
    });
  }

  async remove(id: number) {

    await this.db.book.updateMany({
      where: { category_id: id },
      data: { category_id: null },
    });

    return await this.db.category.delete({
      where: { id },
    });
  }
}
