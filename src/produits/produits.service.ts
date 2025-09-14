import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateProduitDto } from './dto/create-produit.dto';
import { UpdateProduitDto } from './dto/update-produit.dto';
import { QueryProduitDto } from './dto/query-produit.dto';

@Injectable()
export class ProduitsService {
  constructor(private prisma: PrismaService) {}

  async create(data: CreateProduitDto) {
    return this.prisma.produit.create({ data });
  }

  async findAll(query: QueryProduitDto) {
    const { page = 1, limit = 20, type } = query;
    const where = type ? { type } : undefined;

    const [items, total] = await this.prisma.$transaction([
      this.prisma.produit.findMany({
        where,
        skip: (page - 1) * limit,
        take: limit,
        orderBy: { produit_ID: 'asc' },
      }),
      this.prisma.produit.count({ where }),
    ]);

    return { items, total, page, limit };
  }

  async findOne(id: number) {
    const produit = await this.prisma.produit.findUnique({ where: { produit_ID: id } });
    if (!produit) throw new NotFoundException('Produit introuvable');
    return produit;
  }

  async update(id: number, data: UpdateProduitDto) {
    // Vérifie l’existence
    await this.findOne(id);
    return this.prisma.produit.update({ where: { produit_ID: id }, data });
  }

  async remove(id: number) {
    // Vérifie l’existence
    await this.findOne(id);
    await this.prisma.produit.delete({ where: { produit_ID: id } });
    return { deleted: true };
  }
}
