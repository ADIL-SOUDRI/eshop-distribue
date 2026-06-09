-- =========================================
-- FRAGMENTATION SITE 1 - PRODUITS
-- =========================================
-- On sélectionne les produits de la catégorie 50
CREATE TABLE Produits1 AS
SELECT *
FROM Produits@site_global
WHERE idcateg = 50;


-- =========================================
-- FRAGMENTATION SITE 1 - LIGNECOMMANDES
-- =========================================
-- On garde seulement les lignes de commande avec quantité > 100
-- et appartenant aux produits du fragment Produits1
CREATE TABLE LigneCommandes1 AS
SELECT *
FROM LigneCommandes@site_global
WHERE quantite > 100
AND idproduit IN (
    SELECT idproduit
    FROM Produits1
);

-- =========================================
-- FRAGMENTATION SITE 1 - COMMANDES
-- =========================================
-- On récupère les commandes liées aux lignes de commande SITE1
CREATE TABLE Commandes1 AS
SELECT DISTINCT c.*
FROM Commandes@site_global c
JOIN LigneCommandes1 l
ON c.idcommande = l.idcommande;

-- =========================================
-- FRAGMENTATION SITE 1 - CLIENTS
-- =========================================
-- On récupère les clients liés aux commandes SITE1
CREATE TABLE Clients1 AS
SELECT DISTINCT cl.*
FROM Clients@site_global cl
JOIN Commandes1 c
ON cl.idclient = c.idclient;

-- =========================================
-- VERIFICATION DES TABLES CREEES
-- =========================================

-- Liste des tables du schéma courant
SELECT table_name FROM user_tables;

-- Affichage des clients du SITE 1
SELECT * FROM Clients1;
-- Affichage des prosuits du SITE 1
SELECT * FROM Produits1;
-- Affichage des commandes du SITE 1
SELECT * FROM Commandes1;
-- Affichage des ligneCommandes du SITE 1
SELECT * FROM LigneCommandes1;

