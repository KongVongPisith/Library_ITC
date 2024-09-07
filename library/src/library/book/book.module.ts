/* eslint-disable prettier/prettier */
import { Module } from '@nestjs/common';
import { BookService } from './book.service';
import { BookController } from './book.controller';
import { S3Service } from 'src/aws.service';

@Module({
  imports: [],
  controllers: [BookController],
  providers: [BookService,S3Service],
})
export class BookModule {}
