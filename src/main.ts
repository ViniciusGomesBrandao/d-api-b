import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { ValidationPipe } from '@nestjs/common';
import { UsersModule } from './users/users.module';
import { AuthModule } from './auth/auth.module';
import { ModulesModule } from './modules/modules.module';
import { ResourcesModule } from './resources/resources.module';
import { CategoriesModule } from './categories/categories.module';
import { ChatModule } from './chat/chat.module';
import { ReportsModule } from './reports/reports.module';
import { FinanceModule } from './finance/finance.module';
async function bootstrap() {
  const app = await NestFactory.create(AppModule, {
    cors: false
  });
  app.enableCors();
  const config = new DocumentBuilder()
    .setTitle('DueGuard API Documentation')
    .setDescription('Rest Full api documentation')
    .setVersion('1.0')
    .addTag('Auth')
    .addTag('Users')
    .addTag('Finance')
    .addTag('Modules')
    .addTag('Resources')
    .addTag('Categories')
    .addTag('Reports')
    .addTag('Chat')
    .addBearerAuth()
    .build();
  app.useGlobalPipes(new ValidationPipe());
  const document = SwaggerModule.createDocument(app, config, {
    include: [AuthModule, UsersModule, ModulesModule, ResourcesModule, CategoriesModule, ChatModule, ReportsModule, FinanceModule]
  });

  SwaggerModule.setup('api', app, document, {
    swaggerOptions: {
      persistAuthorization: true,
    },
  });
  await app.listen(3001);
}
bootstrap();
