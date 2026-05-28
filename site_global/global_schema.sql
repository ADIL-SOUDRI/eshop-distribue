-- =========================================
-- CREATION DES TABLES (BASE ESHOP)
-- =========================================

CREATE TABLE Clients (
    idclient NUMBER PRIMARY KEY,
    codeclient VARCHAR2(20),
    societe VARCHAR2(100)
);

CREATE TABLE Produits (
    idproduit NUMBER PRIMARY KEY,
    idcateg NUMBER,
    designation VARCHAR2(100),
    prixunitaire NUMBER
);

CREATE TABLE Commandes (
    idcommande NUMBER PRIMARY KEY,
    idclient NUMBER,
    datecommande DATE
);

CREATE TABLE LigneCommandes (
    idlignecommande NUMBER PRIMARY KEY,
    idcommande NUMBER,
    idproduit NUMBER,
    quantite NUMBER,
    remise NUMBER
);

-- BEGIN
--    INSERTLIGNE1@SITE1_LINK(1,1,1,1,1);
-- END;
-- /
-- SELECT * FROM dual@SITE1_LINK;
-- SELECT table_name FROM user_tables;
-- SELECT * FROM dual@SITE_GLOBAL;
-- CREATE DATABASE LINK SITE_GLOBAL
-- CONNECT TO system IDENTIFIED BY oracle
-- USING '//localhost:1521/XEPDB1';
-- CREATE DATABASE LINK SITE1_LINK
-- CONNECT TO system IDENTIFIED BY oracle
-- USING 'XEPDB1';
-- DROP DATABASE LINK SITE_GLOBAL;
-- CREATE DATABASE LINK SITE_GLOBAL
-- CONNECT TO system IDENTIFIED BY oracle
-- USING '(DESCRIPTION=
--   (ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1527))
--   (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
-- )';
-- -- =========================================
-- -- VERIFICATION DES DONNEES
-- -- =========================================

-- SELECT COUNT(*) FROM Produits;

-- SELECT * FROM Produits;


-- -- =========================================
-- -- SUPPRESSION DES TABLES (RESET BASE)
-- -- =========================================

-- DROP TABLE LigneCommandes CASCADE CONSTRAINTS;
-- DROP TABLE Commandes CASCADE CONSTRAINTS;
-- DROP TABLE Produits CASCADE CONSTRAINTS;
-- DROP TABLE Clients CASCADE CONSTRAINTS;


-- -- =========================================
-- -- COMMENTAIRE : EXEMPLE UNION (SCENARIO DISTRIBUE)
-- -- =========================================
-- -- SELECT * FROM Clients1
-- -- UNION ALL
-- -- SELECT * FROM Clients2;


-- -- =========================================
-- -- SUPPRESSION (REDONDANTE - RESET COMPLET)
-- -- =========================================

-- DROP TABLE Clients;
-- DROP TABLE Produits;
-- DROP TABLE Commandes;
-- DROP TABLE LigneCommande;


-- DROP TABLE LigneCommandes CASCADE CONSTRAINTS;
-- DROP TABLE Commandes CASCADE CONSTRAINTS;
-- DROP TABLE Produits CASCADE CONSTRAINTS;
-- DROP TABLE Clients CASCADE CONSTRAINTS;


-- -- =========================================
-- -- LISTE DES TABLES
-- -- =========================================

-- SELECT table_name FROM user_tables;

-- SELECT * FROM Clients;


-- -- =========================================
-- -- TEST DES 4 TABLES
-- -- =========================================

-- SELECT * FROM Clients;
-- SELECT * FROM Produits;
-- SELECT * FROM Commandes;
-- SELECT * FROM LigneCommandes;

-- SELECT COUNT(*) FROM Clients;
-- SELECT COUNT(*) FROM Produits;
-- SELECT COUNT(*) FROM Commandes;
-- SELECT COUNT(*) FROM LigneCommandes;

-- -- CREATE TABLE Clients (
-- --     idclient NUMBER PRIMARY KEY,
-- --     codeclient VARCHAR2(20),
-- --     societe VARCHAR2(100)
-- -- );

-- -- CREATE TABLE Produits (
-- --     idproduit NUMBER PRIMARY KEY,
-- --     idcateg NUMBER,
-- --     designation VARCHAR2(100),
-- --     prixunitaire NUMBER
-- -- );

-- -- CREATE TABLE Commandes (
-- --     idcommande NUMBER PRIMARY KEY,
-- --     idclient NUMBER,
-- --     datecommande DATE
-- -- );

-- -- CREATE TABLE LigneCommandes (
-- --     idlignecommande NUMBER PRIMARY KEY,
-- --     idcommande NUMBER,
-- --     idproduit NUMBER,
-- --     quantite NUMBER,
-- --     remise NUMBER
-- -- );
-- -- SELECT COUNT(*) FROM Produits;

-- -- DROP TABLE LigneCommandes CASCADE CONSTRAINTS;
-- -- DROP TABLE Commandes CASCADE CONSTRAINTS;
-- -- DROP TABLE Produits CASCADE CONSTRAINTS;
-- -- DROP TABLE Clients CASCADE CONSTRAINTS;
-- -- -- SELECT * FROM Clients1
-- -- -- UNION ALL
-- -- -- SELECT * FROM Clients2;

-- -- SELECT * FROM Produits;

-- -- DROP TABLE Clients;
-- -- DROP TABLE Produits;
-- -- DROP TABLE Commandes;
-- -- DROP TABLE LigneCommande;

-- -- DROP TABLE LigneCommandes CASCADE CONSTRAINTS;
-- -- DROP TABLE Commandes CASCADE CONSTRAINTS;
-- -- DROP TABLE Produits CASCADE CONSTRAINTS;
-- -- DROP TABLE Clients CASCADE CONSTRAINTS;

-- -- SELECT table_name FROM user_tables;
-- -- SELECT * FROM Clients;