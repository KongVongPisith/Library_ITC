/* eslint-disable prettier/prettier */
import { Module } from '@nestjs/common';
import { NewsletterService } from './newsletter.service';
import { NewsletterController } from './newsletter.controller';
import { S3Service } from 'src/aws.service';

@Module({
  controllers: [NewsletterController],
  providers: [NewsletterService,S3Service],
})
export class NewsletterModule {}
