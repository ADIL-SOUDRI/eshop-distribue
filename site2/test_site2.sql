-- =========================
-- SITE 2 : INSERT DATA TEST
-- =========================

-- CLIENTS2
INSERT INTO Clients2 VALUES (3, 'C003', 'Client C');
INSERT INTO Clients2 VALUES (4, 'C004', 'Client D');

-- PRODUITS2
INSERT INTO Produits2 VALUES (2001, 35, 'Produit A', 400);
INSERT INTO Produits2 VALUES (2002, 35, 'Produit B', 250);

-- COMMANDES2
INSERT INTO Commandes2 VALUES (201, 3, SYSDATE);
INSERT INTO Commandes2 VALUES (202, 4, SYSDATE);

-- LIGNECOMMANDES2
INSERT INTO LigneCommandes2 VALUES (4, 201, 2001, 60, 5);
INSERT INTO LigneCommandes2 VALUES (5, 202, 2002, 80, 10);

-- =========================
-- CHECK ALL TABLES
-- =========================

SELECT * FROM Clients2;
SELECT * FROM Produits2;
SELECT * FROM Commandes2;
SELECT * FROM LigneCommandes2;

-- =========================
-- UPDATE TEST
-- =========================

UPDATE Clients2
SET societe = 'Updated Client C'
WHERE idclient = 3;

UPDATE Produits2
SET prixunitaire = 500
WHERE idproduit = 2001;

UPDATE LigneCommandes2
SET quantite = 90
WHERE idlignecommande = 4;

-- =========================
-- DELETE TEST
-- =========================

DELETE FROM LigneCommandes2
WHERE idlignecommande = 5;

SELECT * FROM LigneCommandes2;

-- INSERT INTO LigneCommandes2 VALUES (2, 102, 2001, 60, 5);

-- SELECT * FROM LigneCommandes2;

-- UPDATE LigneCommandes2
-- SET quantite = 80
-- WHERE idlignecommande = 2;

-- DELETE FROM LigneCommandes2
-- WHERE idlignecommande = 2;

-- SELECT object_name, status
-- FROM user_objects
-- WHERE object_type = 'PROCEDURE';


-- BEGIN
--   insertligne2(1,1,1,10,0);
-- END;
-- /
-- SELECT DISTINCT idcateg FROM Produits2;
-- SELECT * FROM LigneCommandes2;
-- SELECT c.*
-- FROM Commandes2 c
-- WHERE NOT EXISTS (
--     SELECT 1
--     FROM LigneCommandes2 l
--     WHERE l.idcommande = c.idcommande
-- );

-- SELECT cl.*
-- FROM Clients1 cl
-- WHERE NOT EXISTS (
--     SELECT 1
--     FROM Commandes1 c
--     WHERE c.idclient = cl.idclient
-- );
-- SELECT * FROM Produits1
-- INTERSECT
-- SELECT * FROM Produits2;



-- SELECT * FROM dual;

-- SELECT table_name FROM user_tables;

-- DROP TABLE Clients2;
-- DROP TABLE Produits2;
-- DROP TABLE Commandes2;
-- DROP TABLE LigneCommandes2;



-- DROP TABLE LigneCommandes2 CASCADE CONSTRAINTS;
-- DROP TABLE Commandes2 CASCADE CONSTRAINTS;
-- DROP TABLE Produits2 CASCADE CONSTRAINTS;
-- DROP TABLE Clients2 CASCADE CONSTRAINTS;

-- BEGIN
--    EXECUTE IMMEDIATE 'DROP TABLE Clients2 CASCADE CONSTRAINTS';
-- EXCEPTION WHEN OTHERS THEN NULL;
-- END;
-- /

-- BEGIN EXECUTE IMMEDIATE 'DROP TABLE Produits2 CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
-- /
-- BEGIN EXECUTE IMMEDIATE 'DROP TABLE Commandes2 CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
-- /
-- BEGIN EXECUTE IMMEDIATE 'DROP TABLE LigneCommandes2 CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
-- /

-- BEGIN EXECUTE IMMEDIATE 'DROP TABLE Clients2 CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
-- /
-- BEGIN EXECUTE IMMEDIATE 'DROP TABLE Produits2 CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
-- /
-- BEGIN EXECUTE IMMEDIATE 'DROP TABLE Commandes2 CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
-- /
-- BEGIN EXECUTE IMMEDIATE 'DROP TABLE LigneCommandes2 CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
-- /


-- DROP TABLE LigneCommandes2 CASCADE CONSTRAINTS;
-- DROP TABLE Commandes2 CASCADE CONSTRAINTS;
-- DROP TABLE Produits2 CASCADE CONSTRAINTS;
-- DROP TABLE Clients2 CASCADE CONSTRAINTS;

-- CREATE TABLE Produits2 AS
-- SELECT *
-- FROM Produits@site_global_link
-- WHERE idcateg = 35;
-- SELECT table_name FROM user_tables;

-- SELECT * FROM Produits;
-- SELECT * FROM Produits@site_global_link;


-- -- 

-- SELECT * FROM Produits2 ;
-- SELECT * FROM LigneCommandes2;
-- SELECT * FROM Commandes2;
-- SELECT * FROM Clients2;
-- -- 

-- -- 

-- DROP TRIGGER SYC_INSERT_LIGNE;
-- DROP TRIGGER SYC_UPDATE_LIGNE;
-- DROP TRIGGER SYC_DELETE_LIGNE;
-- --
-- SELECT * FROM dual@SITE_GLOBAL;
-- -- SELECT table_name FROM user_tables; 
-- SELECT object_name, object_type
-- FROM user_objects
-- WHERE object_type = 'PROCEDURE';
-- PERSONNE 1 (TON TRAVAIL)

-- 👉 Tu fais la base + fragmentation + logique locale

-- 📁 1. Création base globale
-- Création des tables :
-- Clients
-- Produits
-- Commandes
-- LigneCommandes
-- Définition des clés :
-- PRIMARY KEY
-- FOREIGN KEY

-- 📌 fichier :

-- site_global/global_schema.sql
-- site_global/constraints.sql
-- ✂️ 2. Fragmentation (TRÈS IMPORTANT)
-- 🔵 SITE1
-- Produits1 : idcateg = 50
-- LigneCommandes1 : quantite > 100
-- Commandes1 liées
-- Clients1 liés

-- 📌 fichier :

-- site1/fragment_site1.sql
-- 🔵 SITE2
-- Produits2 : idcateg = 35
-- LigneCommandes2 : quantite > 50
-- Commandes2 liées
-- Clients2 liés

-- 📌 fichier :

-- site2/fragment_site2.sql
-- ⚙️ 3. Procédures stockées (LOCAL SITE1 + SITE2)

-- Tu crées :

-- ✔ INSERT
-- ✔ UPDATE
-- ✔ DELETE

-- 📌 fichiers :

-- site1/procedures_site1.sql
-- site2/procedures_site2.sql
-- 🧪 4. Tests locaux

-- Tu testes :

-- INSERT data
-- UPDATE data
-- DELETE data
-- SELECT verification

-- 📌 fichiers :

-- site1/test_site1.sql
-- site2/test_site2.sql
-- 🎯 5. Ton objectif

-- ✔ Base globale fonctionnelle
-- ✔ Fragmentation correcte
-- ✔ Procédures fonctionnelles
-- ✔ Tests OK

-- 🔴 👤 PERSONNE 2 (CE QU’IL FAIT)

-- 👉 Il s’occupe de la distribution et optimisation

-- 🔗 1. Triggers de distribution
-- SYC_INSERT_LIGNE
-- SYC_UPDATE_LIGNE
-- SYC_DELETE_LIGNE

-- 👉 ils envoient les données vers Site1 ou Site2

-- 📌 dossier :

-- triggers/
-- 🌐 2. DB LINK (vraie distribution)
-- connexion entre sites
-- communication Site1 ↔ Site2

-- 📌 dossier :

-- db_links/
-- ⚡ 3. Requêtes globales optimisées
-- nombre commandes par client
-- chiffre d’affaires
-- requêtes distribuées
-- 📊 4. Optimisation
-- EXPLAIN PLAN
-- analyse performances
-- index

-- 📌 dossier :

-- site_global/
-- 🌍 5. Requête distribuée finale
-- CA par catégorie (2026)
-- fusion Site1 + Site2
-- 📌 RÉSUMÉ SIMPLE
-- Personne 1	Personne 2
-- Base globale	Triggers
-- Fragmentation	DB Link
-- Procédures	Distribution
-- Tests	Optimisation
-- Site1 + Site2 local	Requêtes globales

-- BEGIN
--     insertligne2(2, 201, 2001, 80, 5);
-- END;
-- /

-- SELECT * FROM LigneCommandes2;
-- SELECT table_name FROM user_tables;

-- -- tester pares triger 
-- SELECT * FROM Produits2;
-- SELECT * FROM LigneCommandes2;

-- SELECT * FROM LigneCommandes2;
-- INSERT INTO LigneCommandes VALUES (20,101,2002,80,5);
-- INSERT INTO LigneCommandes2 VALUES (20,101,2002,80,5);
-- SELECT * FROM LigneCommandes2;
-- SELECT * FROM LigneCommandes2;

-- INSERT INTO Produits VALUES (2002, 35, 'Produit S2', 100);

-- INSERT INTO LigneCommandes VALUES (30,101,2002,80,5);
-- SELECT * FROM LigneCommandes2;
-- SELECT * FROM LigneCommandes2;
-- SELECT * FROM LigneCommandes2;

-- SELECT * FROM LigneCommandes2@site2;

-- SELECT * FROM LigneCommandes2;

-- SELECT object_name, status
-- FROM user_objects
-- WHERE object_type='PROCEDURE';

-- SELECT * FROM SYSTEM.LigneCommandes2;
-- DELETE FROM LigneCommandes2;

-- SELECT * FROM Produits;
-- DELETE FROM LigneCommandes2;