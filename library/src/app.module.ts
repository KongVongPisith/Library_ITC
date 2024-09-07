/* eslint-disable prettier/prettier */
import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { BookModule } from './library/book/book.module';
import { DatabaseModule } from './database/database.module';
import { ConfigModule } from '@nestjs/config';
import { S3Service } from './aws.service';
import { ThesisModule } from './library/thesis/thesis.module';
import { CategoryModule } from './library/category/category.module';
import { DatabaseService } from './database/database.service';
import { BookService } from './library/book/book.service';
import { DepartmentModule } from './library/department/department.module';
import { ThesisService } from './library/thesis/thesis.service';
import { NewsletterModule } from './library/newsletter/newsletter.module';
import { JournalModule } from './library/journal/journal.module';
import { FieldModule } from './library/field/field.module';
import { BookViewController } from './view_controller/book.controller';
import { JournalViewController } from './view_controller/journal.controller';
import { NewsletterViewController } from './view_controller/newletter.controller';
import { ThesisViewController } from './view_controller/Thesis.controller';


@Module({
  imports: [
    BookModule,
    DatabaseModule,
  ConfigModule.forRoot({
    isGlobal: true
  }),
    ThesisModule,
    CategoryModule,
    DepartmentModule,
    NewsletterModule,
    JournalModule,
    FieldModule,
  ],
  controllers: [AppController, BookViewController,JournalViewController, NewsletterViewController,ThesisViewController],
  providers: [AppService, S3Service,DatabaseService,BookService,ThesisService],
})
export class AppModule {};

