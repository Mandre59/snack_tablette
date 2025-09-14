import { IsInt, IsOptional, IsString, Min } from 'class-validator';

export class CreateProduitDto {
  @IsString()
  nom: string;

  @IsOptional() @IsString()
  description?: string;

  @IsInt() @Min(0)
  prix: number;

  @IsString()
  type: string;

  @IsInt() @Min(0)
  prix_menu_supplement: number;

  @IsOptional() @IsInt() @Min(0)
  stock?: number;

  @IsOptional() @IsString()
  image?: string;

  @IsInt()
  categorie_ID: number;

  @IsInt()
  client_ID: number;
}
