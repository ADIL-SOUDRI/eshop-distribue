-- =========================================
-- CONTRAINTES DE CLE ETRANGERE (FOREIGN KEYS)
-- =========================================

-- Lien entre Commandes et Clients
-- Chaque commande appartient à un client existant
ALTER TABLE Commandes
ADD CONSTRAINT fk_cmd_client
FOREIGN KEY (idclient)
REFERENCES Clients(idclient);


-- Lien entre LigneCommandes et Commandes
-- Chaque ligne de commande appartient à une commande existante
ALTER TABLE LigneCommandes
ADD CONSTRAINT fk_ligne_cmd
FOREIGN KEY (idcommande)
REFERENCES Commandes(idcommande);


-- Lien entre LigneCommandes et Produits
-- Chaque ligne de commande correspond à un produit existant
ALTER TABLE LigneCommandes
ADD CONSTRAINT fk_ligne_prod
FOREIGN KEY (idproduit)
REFERENCES Produits(idproduit);


-- ALTER TABLE Commandes
-- ADD CONSTRAINT fk_cmd_client
-- FOREIGN KEY (idclient)
-- REFERENCES Clients(idclient);

-- ALTER TABLE LigneCommandes
-- ADD CONSTRAINT fk_ligne_cmd
-- FOREIGN KEY (idcommande)
-- REFERENCES Commandes(idcommande);

-- ALTER TABLE LigneCommandes
-- ADD CONSTRAINT fk_ligne_prod
-- FOREIGN KEY (idproduit)
-- REFERENCES Produits(idproduit);

-- 
-- ALTER TABLE Commandes
-- ADD CONSTRAINT FK_CMD_CLIENT
-- FOREIGN KEY (idclient)
-- REFERENCES Clients(idclient);

-- ALTER TABLE LigneCommandes
-- ADD CONSTRAINT FK_LIGNE_CMD
-- FOREIGN KEY (idcommande)
-- REFERENCES Commandes(idcommande);

-- ALTER TABLE LigneCommandes
-- ADD CONSTRAINT FK_LIGNE_PROD
-- FOREIGN KEY (idproduit)
-- REFERENCES Produits(idproduit);
-- 


-- SELECT constraint_name FROM user_constraints;
-- SELECT table_name
-- FROM user_tables;

-- DESC Clients;
-- SELECT constraint_name, table_name, constraint_type
-- FROM user_constraints;

