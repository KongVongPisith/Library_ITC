/* eslint-disable prettier/prettier */
import { Injectable } from '@nestjs/common';
import { DatabaseService } from '../../database/database.service';
import { Prisma } from '@prisma/client';
import { S3Service } from 'src/aws.service';

@Injectable()
export class BookService {

  constructor(private readonly db: DatabaseService, private readonly aws: S3Service) { }

  async create(createBook: Prisma.BookUncheckedCreateInput & { category_id: number }, imageFile: Express.Multer.File, pdfFile: Express.Multer.File) {

    // await this.aws.uploadPdf(pdfFile);

    const imageUrl = `https://${process.env.AWS_S3_BUCKET_NAME}.s3.${process.env.AWS_REGION}.amazonaws.com/${imageFile.originalname}`;
    const pdfUrl = `https://${process.env.AWS_S3_BUCKET_PDF}.S3.amazonaws.com/${pdfFile.originalname}`;

    createBook.image = imageUrl;
    createBook.pdf = pdfUrl;

    createBook.category_id = Number(createBook.category_id);

    return await this.db.book.create({
      data: createBook
    });
  }

  async findAll() {
    return await this.db.book.findMany({include:{category:true}});
  }

  async findOne(id: number) {
    return await this.db.book.findUnique({
      where: {
        id,
      },
      include: {
        category:true
      }
    });
  }

  async update(id: number, updateBook: Prisma.BookUncheckedUpdateInput & {category_id:number}, image: Express.Multer.File, pdf:Express.Multer.File) {
    updateBook.image = `https://${process.env.AWS_S3_BUCKET_NAME}.s3.${process.env.AWS_REGION}.amazonaws.com/${image.originalname}`;
    updateBook.pdf = `https://${process.env.AWS_S3_BUCKET_PDF}.S3.amazonaws.com/${pdf.originalname}`;
    updateBook.category_id = Number(updateBook.category_id);
    this.aws.upload(image);
    this.aws.uploadPdf(pdf)
    return await this.db.book.update({
      where: {
        id,
      },
      data: updateBook,
      include: {
        category:true
      }
    });
  }

  async remove(id: number) {
    return await this.db.book.deleteMany({
      where: {
        id
      }
    });
  }

}

    // data: {
      //     title: createBook.title,
      //     isbn: createBook.isbn,
      //     published: createBook.published,
      //     code: createBook.code,
      //     genre: createBook.genre,
      //     author: createBook.author,
      //     image: imageUrl,
      //     pdf: pdfUrl,
      //     category: {
      //       connect: {
      //         id: createBook.category_id,
      //       },
      //     },
      //   },