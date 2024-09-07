/* eslint-disable prettier/prettier */
import { Module } from '@nestjs/common';
import { CategoryService } from './category.service';
import { CategoryController } from './category.controller';
import { S3Service } from 'src/aws.service';

@Module({
  controllers: [CategoryController],
  providers: [CategoryService,S3Service],
})
export class CategoryModule {}
