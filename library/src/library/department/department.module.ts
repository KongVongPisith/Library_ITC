/* eslint-disable prettier/prettier */
import { Module } from '@nestjs/common';
import { DepartmentService } from './department.service';
import { DepartmentController } from './department.controller';
import { S3Service } from 'src/aws.service';

@Module({
  controllers: [DepartmentController],
  providers: [DepartmentService,S3Service],
})
export class DepartmentModule {}
