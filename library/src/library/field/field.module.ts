/* eslint-disable prettier/prettier */
import { Module } from '@nestjs/common';
import { FieldService } from './field.service';
import { FieldController } from './field.controller';
import { S3Service } from 'src/aws.service';

@Module({
  controllers: [FieldController],
  providers: [FieldService, S3Service],
})
export class FieldModule {}
