/* eslint-disable prettier/prettier */
import { Injectable, Logger } from '@nestjs/common';
import { S3Client } from '@aws-sdk/client-s3';
import { Upload } from '@aws-sdk/lib-storage';

@Injectable()
export class S3Service {

  private readonly AWS_S3_BUCKET = process.env.AWS_S3_BUCKET_NAME;
  private readonly AWS_S3_BUCKET_PDF = process.env.AWS_S3_BUCKET_PDF;
  private readonly s3Client: S3Client;
  private sanitizeFileName(fileName: string): string {
    return fileName.replace(/\s+/g, '_').replace(/[^a-zA-Z0-9_\-.]/g, '');
  }

  constructor() {
    this.s3Client = new S3Client({
      region: process.env.AWS_REGION,
      credentials: {
        accessKeyId: process.env.AWS_ACCESS_KEY_ID,
        secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
      },
    });
  }

  async upload(file: Express.Multer.File) {
    try {
      const upload = new Upload({
        client: this.s3Client,
        params: {
          Bucket: this.AWS_S3_BUCKET,
          Key: file.originalname,
          Body: file.buffer,
          ContentType: file.mimetype,
        },
      });

      const result = await upload.done();
      Logger.log(`File uploaded successfully. S3 Response: ${JSON.stringify(result)}`);
    } catch (error) {
      Logger.error(`File upload failed. Error: ${error.message}`);
      throw new Error(`File upload failed: ${error.message}`);
    }
  }

  async uploadPdf(file: Express.Multer.File) {
    try {
      const upload = new Upload({
        client: this.s3Client,
        params: {
          Bucket: this.AWS_S3_BUCKET_PDF,
          Key: file.originalname,
          Body: file.buffer,
          ContentType: file.mimetype,
        },
      });

      const result = await upload.done();
      Logger.log(`File uploaded successfully. S3 Response: ${JSON.stringify(result)}`);
    } catch (error) {
      Logger.error(`File upload failed. Error: ${error.message}`);
      throw new Error(`File upload failed: ${error.message}`);
    }
  }


  // async uploadPdf(file: Express.Multer.File) {
  //   const sanitizedFileName = this.sanitizeFileName(file.originalname);
  //   try {
  //     const upload = new Upload({
  //       client: this.s3Client,
  //       params: {
  //         Bucket: this.ASW_S3_BUCKET_PDF,
  //         // Key: file.originalname,
  //         Key: sanitizedFileName,
  //         Body: file.buffer,
  //         ContentType: file.mimetype,
  //       },
  //     });

  //     const result = await upload.done();
  //     Logger.log(`File uploaded successfully. S3 Response: ${JSON.stringify(result)}`);
  //   } catch (error) {
  //     Logger.error(`File upload failed. Error: ${error.message}`);
  //     throw new Error(`File upload failed: ${error.message}`);
  //   }
  // }

  // constructor() {
  //   this.s3Client = new S3Client({
  //     region: process.env.AWS_REGION,
  //     credentials: {
  //       accessKeyId: process.env.AWS_ACCESS_KEY_ID,
  //       secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
  //     },
  //   });
  // }

  // async upload(file: Express.Multer.File): Promise<PutObjectCommandOutput> {

  //   const originalname = file.originalname;
  //   const buffer = file.buffer;
  //   const mimetype = file.mimetype;

  //   return this.uploadFile(buffer, this.AWS_S3_BUCKET, originalname, mimetype);
  // }

  // async uploadFile(file: Buffer, bucket: string, key: string, contentType: string) {
  //   const params = {
  //     Bucket: bucket,
  //     Key: key,
  //     Body: file,
  //     ContentType: contentType,
  //   };

  //   try {
  //     const command = new PutObjectCommand(params);
  //     const data = await this.s3Client.send(command);
  //     Logger.log(`File uploaded successfully. S3 Response: ${JSON.stringify(data)}`);
  //     return data;
  //   } catch (error) {
  //     Logger.error(error);
  //     throw new Error(`File upload failed: ${error.message}`);
  //   }
  // }

  /////////////////////////////////////////////

  //   constructor() {
  //   this.s3Client = new S3Client({
  //     region: process.env.AWS_REGION,
  //     credentials: {
  //       accessKeyId: process.env.AWS_ACCESS_KEY_ID,
  //       secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
  //     },
  //   });
  // }

  //  async upload(file: Express.Multer.File){
  //   try {
  //     const upload = new Upload({
  //       client: this.s3Client,
  //       params: {
  //         Bucket: this.AWS_S3_BUCKET,
  //         Key: file.originalname,
  //         Body: file.buffer,
  //         ContentType: file.mimetype,
  //       },
  //     });

  //     const result = await upload.done();
  //     Logger.log(`File uploaded successfully. S3 Response: ${JSON.stringify(result)}`);
  //   } catch (error) {
  //     Logger.error(`File upload failed. Error: ${error.message}`);
  //     throw new Error(`File upload failed: ${error.message}`);
  //   }
  // }

  ///////////////////////////////////

  //   constructor() {
  //   this.s3Client = new S3Client({
  //     region: process.env.AWS_REGION,
  //     credentials: {
  //       accessKeyId: process.env.AWS_ACCESS_KEY_ID,
  //       secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
  //     },
  //   });
  // }

  // async upload(file: Express.Multer.File){
  //   try {
  //     const upload = new Upload({
  //       client: this.s3Client,
  //       params: {
  //         Bucket: this.AWS_S3_BUCKET,
  //         Key: file.originalname,
  //         Body: file.buffer,
  //         ContentType: file.mimetype,
  //       },
  //     });

  //     const result = await upload.done();
  //     Logger.log(`File uploaded successfully. S3 Response: ${JSON.stringify(result)}`);
  //   } catch (error) {
  //     Logger.error(`File upload failed. Error: ${error.message}`);
  //     throw new Error(`File upload failed: ${error.message}`);
  //   }
  // }

  //////////////////////////////////////////////////

  // constructor() {
  //   this.s3Client = new S3Client({
  //     region: process.env.AWS_REGION,
  //     credentials: {
  //       accessKeyId: process.env.AWS_ACCESS_KEY_ID,
  //       secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
  //     },
  //   });
  // }

  // async upload(file: Express.Multer.File) {
  //   if (!file) {
  //     throw new Error('No file provided for upload');
  //   }

  //   const fileName = file.originalname;
  //   const fileStream = new Readable();
  //   fileStream.push(file.buffer);
  //   fileStream.push(null);

  //   const fileSize = file.buffer.byteLength;

  //   const params = {
  //     Bucket: this.AWS_S3_BUCKET,
  //     Key: fileName,
  //     Body: fileStream,
  //     ContentType: file.mimetype,
  //     ContentLength: fileSize, 
  //   };

  //   try {
  //     const command = new PutObjectCommand(params);
  //     const data = await this.s3Client.send(command);
  //     Logger.log(`File uploaded successfully. S3 Response: ${JSON.stringify(data)}`);
  //     return `https://${process.env.AWS_S3_BUCKET_NAME}.s3.${process.env.AWS_REGION}.amazonaws.com/${fileName}`;
  //   } catch (error) {
  //     Logger.error(`File upload failed: ${error.message}`);
  //     throw new Error(`File upload failed: ${error.message}`);
  //   }
  // }
  
  
  // private readonly AWS_S3_BUCKET = process.env.AWS_S3_BUCKET_NAME;
  // private readonly s3Client: S3Client;

  //  constructor() {
  //   this.s3Client = new S3Client({
  //     region: process.env.AWS_REGION,
  //     credentials: {
  //       accessKeyId: process.env.AWS_ACCESS_KEY_ID,
  //       secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
  //     },
  //   });
  // }

  // async upload(file: Express.Multer.File): Promise<string> {
  //   const fileName = file.originalname;
  //   const fileStream = new Readable();
  //   fileStream.push(file.buffer);
  //   fileStream.push(null); 

  //   const fileSize = file.buffer.byteLength; 

  //   const params = {
  //     Bucket: process.env.AWS_S3_BUCKET_NAME,
  //     Key: fileName,
  //     Body: fileStream,
  //     ContentType: file.mimetype,
  //     ContentLength: fileSize,
  //   };

  //   try {
  //     const command = new PutObjectCommand(params);
  //     const data = await this.s3Client.send(command);
  //     Logger.log(`File uploaded successfully. S3 Response: ${JSON.stringify(data)}`);
  //     return `https://${process.env.AWS_S3_BUCKET_NAME}.s3.${process.env.AWS_REGION}.amazonaws.com/${fileName}`;
  //   } catch (error) {
  //     Logger.error(`File upload failed: ${error.message}`);
  //     throw new Error(`File upload failed: ${error.message}`);
  //   }
  // }
}
