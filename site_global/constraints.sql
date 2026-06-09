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
