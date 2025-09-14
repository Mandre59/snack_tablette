import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TestModule } from './test/test.module';
import { PrismaModule } from './prisma/prisma.module';
import { ProduitsController } from './produits/produits.controller';
import { ProduitsService } from './produits/produits.service';
import { ProduitsModule } from './produits/produits.module';

@Module({
  imports: [TestModule, PrismaModule, ProduitsModule],
  controllers: [AppController, ProduitsController],
  providers: [AppService, ProduitsService],
})
export class AppModule {}
