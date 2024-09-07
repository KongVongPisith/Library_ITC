/* eslint-disable prettier/prettier */
import { Module } from '@nestjs/common';
import { ThesisService } from './thesis.service';
import { ThesisController } from './thesis.controller';
import { S3Service } from 'src/aws.service';

@Module({
  controllers: [ThesisController],
  providers: [ThesisService,S3Service],
})
export class ThesisModule {}
