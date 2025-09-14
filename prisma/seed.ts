
// prisma/seed.ts
import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

async function main() {
  const client = await prisma.client.create({
    data: {
      nom: 'Client Test',   
    },
  });

  const categorie = await prisma.categorie.create({
    data: {
      nom: 'Boisson',
      client_ID: client.client_ID
    },
  });

  const produit = await prisma.produit.create({
    data: {
      nom: 'Coca',
      description: 'Boisson gazeuse',
      prix: 250,
      type: 'boisson',
      prix_menu_supplement: 0,
      stock: 100,
      image: null, // champ optionnel
      categorie_ID: categorie.categorie_ID,
      client_ID: client.client_ID
    },
  });

  console.log('✅ Données de test insérées');
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
