import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { UsersModule } from './users/users.module';
import { BigdatacorpService } from '@app/bigdatacorp';
import { BigDataModule } from './bigdata/bigdata.module';
import { ResourcesModule } from './resources/resources.module';
import { ModulesModule } from './modules/modules.module';
import { CategoriesModule } from './categories/categories.module';
import { MakePdfService } from './_services/make-pdf/make-pdf.service';
import { ReportsModule } from './reports/reports.module';
import { AuthModule } from './auth/auth.module';
import { ChatModule } from './chat/chat.module';
import { FinanceModule } from './finance/finance.module';
import { BullModule } from '@nestjs/bull';

@Module({
  imports: [
    UsersModule, 
    BigDataModule, 
    ResourcesModule, 
    ModulesModule, 
    CategoriesModule, 
    ReportsModule, 
    AuthModule, 
    ChatModule, 
    FinanceModule,
    BullModule.forRoot({
      redis: {
        host: 'localhost',
        port: 6379
      }
    })
  ],
  controllers: [AppController],
  providers: [AppService, BigdatacorpService, MakePdfService],
})
export class AppModule {}
