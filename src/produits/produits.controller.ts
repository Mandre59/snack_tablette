import { Controller, Get, Post, Body, Param, Put, Delete, Query } from '@nestjs/common';
import { ApiTags, ApiOkResponse, ApiCreatedResponse } from '@nestjs/swagger';
import { ProduitsService } from './produits.service';
import { CreateProduitDto } from './dto/create-produit.dto';
import { UpdateProduitDto } from './dto/update-produit.dto';
import { QueryProduitDto } from './dto/query-produit.dto';

@ApiTags('Produits')
@Controller('produits')
export class ProduitsController {
  constructor(private readonly produitsService: ProduitsService) {}

  @Post()
  @ApiCreatedResponse({ description: 'Produit créé.' })
  create(@Body() dto: CreateProduitDto) {
    return this.produitsService.create(dto);
  }

  @Get()
  @ApiOkResponse({ description: 'Liste paginée des produits.' })
  findAll(@Query() query: QueryProduitDto) {
    return this.produitsService.findAll(query);
  }

  @Get(':id')
  @ApiOkResponse({ description: 'Produit par ID.' })
  findOne(@Param('id') id: string) {
    return this.produitsService.findOne(Number(id));
  }

  @Put(':id')
  @ApiOkResponse({ description: 'Produit mis à jour.' })
  update(@Param('id') id: string, @Body() dto: UpdateProduitDto) {
    return this.produitsService.update(Number(id), dto);
  }

  @Delete(':id')
  @ApiOkResponse({ description: 'Produit supprimé.' })
  remove(@Param('id') id: string) {
    return this.produitsService.remove(Number(id));
  }
}
