-- =========================
-- SITE 2 : INSERT DATA TEST
-- =========================
SELECT object_name FROM user_objects WHERE object_type='PROCEDURE';
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
INSERT INTO LigneCommandes2 VALUES (5, 10, 1002, 60, 5);
INSERT INTO LigneCommandes2 VALUES (6, 11, 1003, 80, 10);
COMMIT;
-- =========================
-- CHECK ALL TABLES
-- =========================

SELECT * FROM Clients2;
SELECT * FROM Produits2;
SELECT * FROM Commandes2;
SELECT * FROM LigneCommandes2
ORDER BY IDLIGNECOMMANDE ASC;
SELECT * FROM LigneCommandes2 where IDLIGNECOMMANDE=3;
SELECT * FROM LigneCommandes2 where IDLIGNECOMMANDE=23;


DELETE FROM LigneCommandes2;
DELETE FROM Commandes2;
DELETE FROM Produits2;
DELETE FROM Clients2;
COMMIT;

UPDATE LigneCommandes2
SET quantite = 31
WHERE idlignecommande = 2;

COMMIT;
-- =========================
-- UPDATE TEST
-- =========================

-- UPDATE Clients2
-- SET societe = 'Updated Client C'
-- WHERE idclient = 3;

-- UPDATE Produits2
-- SET prixunitaire = 500
-- WHERE idproduit = 2001;

UPDATE LigneCommandes2
SET quantite = 80
WHERE idlignecommande = 5;
COMMIT;
-- =========================
-- DELETE TEST
-- =========================

SELECT* FROM LigneCommandes2
WHERE idlignecommande = 6;
BEGIN

    DELETE FROM LigneCommandes2
    WHERE idlignecommande = 6;

    DBMS_OUTPUT.PUT_LINE('DELETE ligne 3 effectué.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erreur DELETE SITE2 : ' || SQLERRM);

END;
/
COMMIT;

SELECT * FROM LigneCommandes2;
BEGIN

    DELETE FROM LigneCommandes2;
    DELETE FROM Commandes2;
    DELETE FROM Produits2;
    DELETE FROM Clients2;
    COMMIT;

    DBMS_OUTPUT.PUT_LINE(
        'Toutes les données ont été supprimées.'
    );

EXCEPTION
    WHEN OTHERS THEN

        ROLLBACK;

        DBMS_OUTPUT.PUT_LINE(
            'Erreur : ' || SQLERRM
        );

END;
/
Commit;

-- ========================================================
-- CREATION ET CONFIGURATION DE L'UTILISATEUR (SITE 2)
-- ========================================================

CREATE USER site2_user IDENTIFIED BY site123;
GRANT CONNECT, RESOURCE TO site2_user;

-- Vérification de la présence de l'utilisateur dans la base de données
SELECT username
FROM all_users;


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
