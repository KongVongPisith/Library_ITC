/* eslint-disable prettier/prettier */
import { Module } from '@nestjs/common';
import { JournalService } from './journal.service';
import { JournalController } from './journal.controller';
import { S3Service } from 'src/aws.service';

@Module({
  controllers: [JournalController],
  providers: [JournalService, S3Service],
})
export class JournalModule {}
