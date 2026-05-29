-- =====================================================
-- SITE 1 : INSERT / UPDATE / DELETE TEST
-- =====================================================


-- =========================
-- 1. INSERT DATA TEST
-- =========================

BEGIN

    -- CLIENTS1
    INSERT INTO Clients1 VALUES (1, 'C001', 'Client A');
    INSERT INTO Clients1 VALUES (2, 'C002', 'Client B');

    -- PRODUITS1
    INSERT INTO Produits1 VALUES (1001, 50, 'Produit X', 500);
    INSERT INTO Produits1 VALUES (1002, 50, 'Produit Y', 300);

    -- COMMANDES1
    INSERT INTO Commandes1 VALUES (101, 1, SYSDATE);
    INSERT INTO Commandes1 VALUES (102, 2, SYSDATE);

    -- LIGNECOMMANDES1
    INSERT INTO LigneCommandes1 VALUES (1, 101, 1001, 120, 10);
    INSERT INTO LigneCommandes1 VALUES (2, 101, 1002, 150, 5);
    INSERT INTO LigneCommandes1 VALUES (3, 102, 1001, 200, 0);

    DBMS_OUTPUT.PUT_LINE('Insertion SITE 1 réussie.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erreur INSERT SITE1 : ' || SQLERRM);

END;
/
COMMIT;


-- =========================
-- 2. CHECK ALL TABLES
-- =========================

BEGIN
    DBMS_OUTPUT.PUT_LINE('=== CHECK SITE 1 TABLES ===');
END;
/

SELECT * FROM Clients1;
SELECT * FROM Produits1;
SELECT * FROM Commandes1;
SELECT * FROM LigneCommandes1;


-- =========================
-- 3. UPDATE TEST
-- =========================

BEGIN

    UPDATE Clients1
    SET societe = 'Updated Client A'
    WHERE idclient = 1;

    UPDATE Produits1
    SET prixunitaire = 600
    WHERE idproduit = 1001;

    UPDATE LigneCommandes1
    SET quantite = 180
    WHERE idlignecommande = 1;

    DBMS_OUTPUT.PUT_LINE('UPDATE SITE 1 terminé.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erreur UPDATE SITE1 : ' || SQLERRM);

END;
/
COMMIT;


-- =========================
-- 4. DELETE TEST (UNE LIGNE)
-- =========================

BEGIN

    DELETE FROM LigneCommandes1
    WHERE idlignecommande = 3;

    DBMS_OUTPUT.PUT_LINE('DELETE ligne 3 effectué.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erreur DELETE SITE1 : ' || SQLERRM);

END;
/
COMMIT;


-- =========================
-- 5. DELETE GLOBAL CLEANUP
-- =========================

BEGIN

    DELETE FROM LigneCommandes1;
    DELETE FROM Commandes1;
    DELETE FROM Produits1;
    DELETE FROM Clients1;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Toutes les données SITE1 supprimées.');

EXCEPTION
    WHEN OTHERS THEN

        ROLLBACK;

        DBMS_OUTPUT.PUT_LINE('Erreur CLEAN DELETE SITE1 : ' || SQLERRM);

END;
/
COMMIT;


-- =========================
-- 6. FINAL CHECK
-- =========================

SELECT * FROM Clients1;
SELECT * FROM Produits1;
SELECT * FROM Commandes1;
SELECT * FROM LigneCommandes1;

-- INSERT INTO LigneCommandes1 VALUES (1, 101, 1001, 120, 10);

-- SELECT * FROM LigneCommandes1;

-- UPDATE LigneCommandes1
-- SET quantite = 180
-- WHERE idlignecommande = 1;

-- DELETE FROM LigneCommandes1
-- WHERE idlignecommande = 1;


-- SELECT * FROM dual;



-- DROP TABLE LigneCommandes1 CASCADE CONSTRAINTS;
-- DROP TABLE Commandes1 CASCADE CONSTRAINTS;
-- DROP TABLE Produits1 CASCADE CONSTRAINTS;
-- DROP TABLE Clients1 CASCADE CONSTRAINTS;

-- BEGIN EXECUTE IMMEDIATE 'DROP TABLE Clients1 CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
-- /
-- BEGIN EXECUTE IMMEDIATE 'DROP TABLE Produits1 CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
-- /
-- BEGIN EXECUTE IMMEDIATE 'DROP TABLE Commandes1 CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
-- /
-- BEGIN EXECUTE IMMEDIATE 'DROP TABLE LigneCommandes1 CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
-- /


-- BEGIN
--     insertligne1(1, 101, 1001, 120, 10);
-- END;
-- /
-- SELECT * FROM LigneCommandes1;

-- BEGIN
--     updateligne1(1, 1002, 150, 5);
-- END;
-- /

-- BEGIN
--     deleteligne1(1);
-- END;
-- /

-- SELECT table_name FROM user_tables;
-- DROP TRIGGER SYC_INSERT_LIGNE;
-- DROP TRIGGER SYC_UPDATE_LIGNE;
-- DROP TRIGGER SYC_DELETE_LIGNE;
-- -- tester apres le trigger :
-- SELECT * FROM Produits1;
-- SELECT * FROM LigneCommandes1;

-- SELECT * FROM LigneCommandes1;


-- INSERT INTO LigneCommandes1@site1 VALUES (50,101,1001,120,10);
-- INSERT INTO LigneCommandes VALUES (10,101,1001,120,10);
-- SELECT * FROM LigneCommandes1;
-- ROLLBACK;

-- -- 
-- SELECT * FROM LigneCommandes1;
-- SELECT * FROM LigneCommandes2@site2;
-- -- 

-- SELECT table_name FROM user_tables;
-- -- verifier les procedures :
-- SELECT object_name, status
-- FROM user_objects
-- WHERE object_type='PROCEDURE';
-- DELETE FROM LigneCommandes1;
-- SELECT * FROM Produits;
-- SELECT * FROM LigneCommandes1;
-- SELECT * from Produits1;

-- SELECT table_name FROM user_tables;
-- DELETE FROM LigneCommandes1;

-- SELECT * FROM dual@SITE_GLOBAL;

-- SELECT object_name, object_type
-- FROM user_objects
-- WHERE object_type = 'PROCEDURE';

-- SELECT argument_name, data_type
-- FROM user_arguments
-- WHERE object_name = 'INSERTLIGNE1';