/* eslint-disable prettier/prettier */
import {
  Controller,
} from '@nestjs/common';
import { DatabaseService } from './database/database.service';


@Controller()
export class AppController {

  constructor(private prisma: DatabaseService) {}

}


