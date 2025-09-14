-- CreateTable
CREATE TABLE "Client" (
    "client_ID" SERIAL NOT NULL,
    "nom" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Client_pkey" PRIMARY KEY ("client_ID")
);

-- CreateTable
CREATE TABLE "User" (
    "user_ID" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "client_ID" INTEGER NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("user_ID")
);

-- CreateTable
CREATE TABLE "Categorie" (
    "categorie_ID" SERIAL NOT NULL,
    "nom" TEXT NOT NULL,
    "client_ID" INTEGER NOT NULL,

    CONSTRAINT "Categorie_pkey" PRIMARY KEY ("categorie_ID")
);

-- CreateTable
CREATE TABLE "Produit" (
    "produit_ID" SERIAL NOT NULL,
    "nom" TEXT NOT NULL,
    "description" TEXT,
    "prix" INTEGER NOT NULL,
    "type" TEXT NOT NULL,
    "prix_menu_supplement" INTEGER NOT NULL,
    "categorie_ID" INTEGER NOT NULL,
    "client_ID" INTEGER NOT NULL,

    CONSTRAINT "Produit_pkey" PRIMARY KEY ("produit_ID")
);

-- CreateTable
CREATE TABLE "Option_Produit" (
    "option_ID" SERIAL NOT NULL,
    "nom" TEXT NOT NULL,
    "produit_ID" INTEGER NOT NULL,

    CONSTRAINT "Option_Produit_pkey" PRIMARY KEY ("option_ID")
);

-- CreateTable
CREATE TABLE "Produit_Commande_Option" (
    "id" SERIAL NOT NULL,
    "commandeProduit_ID" INTEGER NOT NULL,
    "option_ID" INTEGER NOT NULL,
    "ajout" BOOLEAN NOT NULL,

    CONSTRAINT "Produit_Commande_Option_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Ingredient" (
    "ingredient_ID" SERIAL NOT NULL,
    "nom" TEXT NOT NULL,

    CONSTRAINT "Ingredient_pkey" PRIMARY KEY ("ingredient_ID")
);

-- CreateTable
CREATE TABLE "Ingredient_Produit" (
    "id" SERIAL NOT NULL,
    "produit_ID" INTEGER NOT NULL,
    "ingredient_ID" INTEGER NOT NULL,

    CONSTRAINT "Ingredient_Produit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Menu" (
    "menu_ID" SERIAL NOT NULL,
    "nom" TEXT NOT NULL,
    "prix" INTEGER NOT NULL,

    CONSTRAINT "Menu_pkey" PRIMARY KEY ("menu_ID")
);

-- CreateTable
CREATE TABLE "Menu_Composition" (
    "id" SERIAL NOT NULL,
    "menu_ID" INTEGER NOT NULL,
    "nom" TEXT NOT NULL,

    CONSTRAINT "Menu_Composition_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Composition" (
    "id" SERIAL NOT NULL,
    "menuComposition_ID" INTEGER NOT NULL,
    "produit_ID" INTEGER NOT NULL,
    "supplement" INTEGER NOT NULL,

    CONSTRAINT "Composition_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Commande" (
    "commande_ID" SERIAL NOT NULL,
    "client_ID" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Commande_pkey" PRIMARY KEY ("commande_ID")
);

-- CreateTable
CREATE TABLE "Commande_Produit" (
    "commandeProduit_ID" SERIAL NOT NULL,
    "commande_ID" INTEGER NOT NULL,
    "produit_ID" INTEGER NOT NULL,

    CONSTRAINT "Commande_Produit_pkey" PRIMARY KEY ("commandeProduit_ID")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_client_ID_fkey" FOREIGN KEY ("client_ID") REFERENCES "Client"("client_ID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Categorie" ADD CONSTRAINT "Categorie_client_ID_fkey" FOREIGN KEY ("client_ID") REFERENCES "Client"("client_ID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Produit" ADD CONSTRAINT "Produit_categorie_ID_fkey" FOREIGN KEY ("categorie_ID") REFERENCES "Categorie"("categorie_ID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Produit" ADD CONSTRAINT "Produit_client_ID_fkey" FOREIGN KEY ("client_ID") REFERENCES "Client"("client_ID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Option_Produit" ADD CONSTRAINT "Option_Produit_produit_ID_fkey" FOREIGN KEY ("produit_ID") REFERENCES "Produit"("produit_ID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Produit_Commande_Option" ADD CONSTRAINT "Produit_Commande_Option_commandeProduit_ID_fkey" FOREIGN KEY ("commandeProduit_ID") REFERENCES "Commande_Produit"("commandeProduit_ID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Produit_Commande_Option" ADD CONSTRAINT "Produit_Commande_Option_option_ID_fkey" FOREIGN KEY ("option_ID") REFERENCES "Option_Produit"("option_ID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ingredient_Produit" ADD CONSTRAINT "Ingredient_Produit_produit_ID_fkey" FOREIGN KEY ("produit_ID") REFERENCES "Produit"("produit_ID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ingredient_Produit" ADD CONSTRAINT "Ingredient_Produit_ingredient_ID_fkey" FOREIGN KEY ("ingredient_ID") REFERENCES "Ingredient"("ingredient_ID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Menu_Composition" ADD CONSTRAINT "Menu_Composition_menu_ID_fkey" FOREIGN KEY ("menu_ID") REFERENCES "Menu"("menu_ID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Composition" ADD CONSTRAINT "Composition_menuComposition_ID_fkey" FOREIGN KEY ("menuComposition_ID") REFERENCES "Menu_Composition"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Composition" ADD CONSTRAINT "Composition_produit_ID_fkey" FOREIGN KEY ("produit_ID") REFERENCES "Produit"("produit_ID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Commande" ADD CONSTRAINT "Commande_client_ID_fkey" FOREIGN KEY ("client_ID") REFERENCES "Client"("client_ID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Commande_Produit" ADD CONSTRAINT "Commande_Produit_commande_ID_fkey" FOREIGN KEY ("commande_ID") REFERENCES "Commande"("commande_ID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Commande_Produit" ADD CONSTRAINT "Commande_Produit_produit_ID_fkey" FOREIGN KEY ("produit_ID") REFERENCES "Produit"("produit_ID") ON DELETE RESTRICT ON UPDATE CASCADE;
