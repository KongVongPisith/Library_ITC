/* eslint-disable prettier/prettier */
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { NestExpressApplication } from '@nestjs/platform-express';
import { join } from 'path';
import * as methodOverride from 'method-override';
import * as session from 'express-session';
import * as flash from 'connect-flash';

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);

  app.useStaticAssets(join(__dirname, '..', './src/public'));
  app.setBaseViewsDir(join(__dirname, '..', './src/views'));
  app.setViewEngine('ejs')
  app.use(methodOverride('_method'));

  app.use(
    session({
      secret: 'secret-key',
      resave: false,
      saveUninitialized: false,
    }),
  );
  app.use(flash());
  
  await app.listen(3000);
}
bootstrap();
