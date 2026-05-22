-- =========================================
-- FRAGMENTATION SITE 2 (LOCAL)
-- =========================================

-- Produits du SITE2 : catégorie 35
CREATE TABLE Produits2 AS
SELECT *
FROM Produits@SITE_GLOBAL
WHERE idcateg = 35;


-- LigneCommandes SITE2 : quantite > 50 + produits du SITE2
CREATE TABLE LigneCommandes2 AS
SELECT *
FROM LigneCommandes@SITE_GLOBAL
WHERE quantite > 50
AND idproduit IN (
    SELECT idproduit
    FROM Produits2
);
-- Commandes SITE2 : liées aux lignes de commande SITE2
CREATE TABLE Commandes2 AS
SELECT DISTINCT c.*
FROM Commandes@SITE_GLOBAL c
JOIN LigneCommandes2 l
ON c.idcommande = l.idcommande;

-- Clients SITE2 : liés aux commandes SITE2
CREATE TABLE Clients2 AS
SELECT DISTINCT cl.*
FROM Clients@SITE_GLOBAL cl
JOIN Commandes2 c
ON cl.idclient = c.idclient;

-- =========================================
-- FRAGMENTATION SITE 2 (VERSION DISTANTE VIA DATABASE LINK)
-- =========================================

-- Produits2 récupérés depuis SITE1 via database link
CREATE TABLE Produits2 AS
SELECT * FROM Produits@site1
WHERE idcateg = 35;


-- LigneCommandes2 depuis SITE1
CREATE TABLE LigneCommandes2 AS
SELECT *
FROM LigneCommandes@site1
WHERE quantite > 50
AND idproduit IN (SELECT idproduit FROM Produits2);


-- Commandes2 depuis SITE1
CREATE TABLE Commandes2 AS
SELECT DISTINCT c.*
FROM Commandes@site1 c
JOIN LigneCommandes2 l
ON c.idcommande = l.idcommande;


-- Clients2 depuis SITE1
CREATE TABLE Clients2 AS
SELECT DISTINCT cl.*
FROM Clients@site1 cl
JOIN Commandes2 c
ON cl.idclient = c.idclient;


-- =========================================
-- VERIFICATION DES TABLES
-- =========================================

SELECT table_name FROM user_tables;


-- =========================================
-- SUPPRESSION DES TABLES SITE2
-- =========================================

DROP TABLE Clients2 CASCADE CONSTRAINTS;
DROP TABLE Commandes2 CASCADE CONSTRAINTS;
DROP TABLE Produits2 CASCADE CONSTRAINTS;
DROP TABLE LigneCommandes2 CASCADE CONSTRAINTS;


-- =========================================
-- RECREATION SIMPLE PRODUITS2
-- =========================================

CREATE TABLE Produits2 AS
SELECT *
FROM Produits
WHERE idcateg = 35;


-- =========================================
-- TESTS
-- =========================================

SELECT * FROM Produits2;
SELECT * FROM LigneCommandes2;

-- CREATE TABLE Produits2 AS
-- SELECT *
-- FROM Produits
-- WHERE idcateg = 35;
-- CREATE TABLE LigneCommandes2 AS
-- SELECT *
-- FROM LigneCommandes
-- WHERE quantite > 50
-- AND idproduit IN (SELECT idproduit FROM Produits2);
-- CREATE TABLE Commandes2 AS
-- SELECT DISTINCT c.*
-- FROM Commandes c
-- JOIN LigneCommandes2 l ON c.idcommande = l.idcommande;
-- CREATE TABLE Clients2 AS
-- SELECT DISTINCT cl.*
-- FROM Clients cl
-- JOIN Commandes2 c ON cl.idclient = c.idclient;
-- -- 
-- CREATE TABLE Produits2 AS
-- SELECT * FROM Produits@site1
-- WHERE idcateg = 35;

-- CREATE TABLE LigneCommandes2 AS
-- SELECT *
-- FROM LigneCommandes@site1
-- WHERE quantite > 50
-- AND idproduit IN (SELECT idproduit FROM Produits2);


-- CREATE TABLE Commandes2 AS
-- SELECT DISTINCT c.*
-- FROM Commandes@site1 c
-- JOIN LigneCommandes2 l
-- ON c.idcommande = l.idcommande;

-- CREATE TABLE Clients2 AS
-- SELECT DISTINCT cl.*
-- FROM Clients@site1 cl
-- JOIN Commandes2 c
-- ON cl.idclient = c.idclient;
-- -- 

-- SELECT table_name FROM user_tables;

-- DROP TABLE Clients2 CASCADE CONSTRAINTS;
-- DROP TABLE Commandes2 CASCADE CONSTRAINTS;
-- DROP TABLE Produits2 CASCADE CONSTRAINTS;
-- DROP TABLE LigneCommandes2 CASCADE CONSTRAINTS;

-- CREATE TABLE Produits2 AS
-- SELECT *
-- FROM Produits
-- WHERE idcateg = 35;

-- SELECT * FROM Produits2;
-- SELECT * FROM LigneCommandes2;