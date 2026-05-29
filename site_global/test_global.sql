-- =====================================================
-- FICHIER : test_database.sql
-- OBJECTIF : TEST GLOBAL BASE DE DONNEES
-- =====================================================


-- =========================
-- 1. AFFICHAGE DES TABLES
-- =========================

BEGIN
    DBMS_OUTPUT.PUT_LINE('=== AFFICHAGE DES TABLES ===');
END;
/

SELECT * FROM Clients;
SELECT * FROM Produits;
SELECT * FROM Commandes;
SELECT * FROM LigneCommandes;

COMMIT;


-- =========================
-- 2. INSERTION CLIENTS
-- =========================

BEGIN

    INSERT INTO Clients VALUES (1, 'CLI001', 'Société Atlas');
    INSERT INTO Clients VALUES (2, 'CLI002', 'Société Omega');
    INSERT INTO Clients VALUES (3, 'CLI003', 'Société Nova');
    INSERT INTO Clients VALUES (4, 'CLI004', 'Société Delta');

    DBMS_OUTPUT.PUT_LINE('Clients insérés avec succès.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erreur Clients : ' || SQLERRM);

END;
/
COMMIT;


-- =========================
-- 3. INSERTION PRODUITS
-- =========================

BEGIN

    INSERT INTO Produits VALUES (1001, 50, 'Serveur Dell PowerEdge', 20000);
    INSERT INTO Produits VALUES (1002, 50, 'PC HP Workstation', 12000);
    INSERT INTO Produits VALUES (2001, 35, 'Clavier Logitech', 300);
    INSERT INTO Produits VALUES (2002, 35, 'Souris Gaming', 150);
    INSERT INTO Produits VALUES (2003, 35, 'Écran Samsung 24"', 1800);

    INSERT INTO Produits VALUES (3001, 50, 'Serveur IBM XSeries', 30000);
    INSERT INTO Produits VALUES (3002, 50, 'Laptop Lenovo ThinkPad', 15000);
    INSERT INTO Produits VALUES (4001, 35, 'Casque Audio Sony', 600);
    INSERT INTO Produits VALUES (4002, 35, 'Webcam HD Logitech', 450);
    INSERT INTO Produits VALUES (4003, 35, 'Imprimante Epson', 2200);

    DBMS_OUTPUT.PUT_LINE('Produits insérés avec succès.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erreur Produits : ' || SQLERRM);

END;
/
COMMIT;


-- =========================
-- 4. INSERTION COMMANDES
-- =========================

BEGIN

    INSERT INTO Commandes VALUES (1, 1, TO_DATE('2026-01-10','YYYY-MM-DD'));
    INSERT INTO Commandes VALUES (2, 2, TO_DATE('2026-02-15','YYYY-MM-DD'));
    INSERT INTO Commandes VALUES (3, 3, TO_DATE('2026-03-20','YYYY-MM-DD'));
    INSERT INTO Commandes VALUES (4, 4, TO_DATE('2026-04-05','YYYY-MM-DD'));

    INSERT INTO Commandes VALUES (5, 1, TO_DATE('2026-05-01','YYYY-MM-DD'));
    INSERT INTO Commandes VALUES (6, 2, TO_DATE('2026-05-10','YYYY-MM-DD'));
    INSERT INTO Commandes VALUES (7, 3, TO_DATE('2026-06-15','YYYY-MM-DD'));
    INSERT INTO Commandes VALUES (8, 4, TO_DATE('2026-07-20','YYYY-MM-DD'));

    DBMS_OUTPUT.PUT_LINE('Commandes insérées avec succès.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erreur Commandes : ' || SQLERRM);

END;
/
COMMIT;


-- =========================
-- 5. INSERTION LIGNE COMMANDES
-- =========================

BEGIN

    INSERT INTO LigneCommandes VALUES (1, 1, 1001, 120, 5);
    INSERT INTO LigneCommandes VALUES (2, 2, 1002, 150, 10);
    INSERT INTO LigneCommandes VALUES (3, 3, 2001, 20, 0);
    INSERT INTO LigneCommandes VALUES (4, 4, 2002, 50, 2);
    INSERT INTO LigneCommandes VALUES (5, 1, 2003, 30, 3);

    INSERT INTO LigneCommandes VALUES (6, 5, 3001, 200, 10);
    INSERT INTO LigneCommandes VALUES (7, 6, 3002, 120, 5);
    INSERT INTO LigneCommandes VALUES (8, 7, 4001, 25, 0);
    INSERT INTO LigneCommandes VALUES (9, 8, 4002, 40, 3);
    INSERT INTO LigneCommandes VALUES (10, 9, 4003, 60, 2);

    INSERT INTO LigneCommandes VALUES (11, 1, 1001, 150, 2);
    INSERT INTO LigneCommandes VALUES (12, 2, 1002, 100, 5);
    INSERT INTO LigneCommandes VALUES (13, 3, 3001, 150, 8);
    INSERT INTO LigneCommandes VALUES (14, 4, 3002, 154, 3);
    INSERT INTO LigneCommandes VALUES (15, 1, 3001, 145, 4);

    INSERT INTO LigneCommandes VALUES (16, 5, 2001, 60, 1);
    INSERT INTO LigneCommandes VALUES (17, 6, 2002, 70, 0);
    INSERT INTO LigneCommandes VALUES (18, 7, 2003, 80, 2);
    INSERT INTO LigneCommandes VALUES (19, 8, 4001, 90, 1);
    INSERT INTO LigneCommandes VALUES (20, 9, 4002, 85, 0);

    INSERT INTO LigneCommandes VALUES (28, 1, 3001, 121, 5);
    INSERT INTO LigneCommandes VALUES (23, 12, 2001, 40, 2);
    INSERT INTO LigneCommandes VALUES (25, 3, 1001, 120, 0);
    INSERT INTO LigneCommandes VALUES (27, 1, 1001, 120, 5);
    INSERT INTO LigneCommandes VALUES (29, 1, 1001, 120, 5);

    DBMS_OUTPUT.PUT_LINE('Lignes de commandes insérées avec succès.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erreur LigneCommandes : ' || SQLERRM);

END;
/
COMMIT;


-- =========================
-- 6. TEST DISTRIBUÉ (DB LINK)
-- =========================

BEGIN
    DBMS_OUTPUT.PUT_LINE('=== TEST DB LINK ===');
END;
/

SELECT * FROM LigneCommandes1@SITE1_LINK;
SELECT * FROM LigneCommandes2@SITE2_LINK;


-- =========================
-- 7. UPDATE LIGNE COMMANDES
-- =========================

BEGIN

    UPDATE LigneCommandes
    SET quantite = 200,
        remise = 15
    WHERE idlignecommande = 1;

    UPDATE LigneCommandes
    SET idproduit = 1001,
        quantite = 300,
        remise = 5
    WHERE idlignecommande = 2;

    DBMS_OUTPUT.PUT_LINE('Mise à jour effectuée.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erreur UPDATE : ' || SQLERRM);

END;
/
COMMIT;


-- =========================
-- 8. DELETE DONNEES
-- =========================

BEGIN

    DELETE FROM LigneCommandes
    WHERE idlignecommande = 2;

    DELETE FROM LigneCommandes
    WHERE idlignecommande = 5;

    DBMS_OUTPUT.PUT_LINE('Suppressions effectuées.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erreur DELETE : ' || SQLERRM);

END;
/
COMMIT;

BEGIN

    DELETE FROM LigneCommandes;
    -- DELETE FROM Commandes;
    -- DELETE FROM Produits;
    -- DELETE FROM Clients;

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



-- ============================================================================
-- 4. TEST DES CONNEXIONS
-- ============================================================================

DECLARE
    v_test NUMBER;
BEGIN
    -- Test vers SITE1
    BEGIN
        EXECUTE IMMEDIATE 'SELECT 1 FROM DUAL@SITE1_LINK' INTO v_test;
        DBMS_OUTPUT.PUT_LINE(' GLOBALE → SITE1: CONNECTE (via SITE1_LINK)');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(' GLOBALE → SITE1: NON CONNECTE');
            DBMS_OUTPUT.PUT_LINE('   Erreur: ' || SQLERRM);
    END;
    
    -- Test vers SITE2
    BEGIN
        EXECUTE IMMEDIATE 'SELECT 1 FROM DUAL@SITE2_LINK' INTO v_test;
        DBMS_OUTPUT.PUT_LINE(' GLOBALE → SITE2: CONNECTE (via SITE2_LINK)');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(' GLOBALE → SITE2: NON CONNECTE');
            DBMS_OUTPUT.PUT_LINE('   Erreur: ' || SQLERRM);
    END;
END;
/
-- Test simple avec DUAL
SELECT 'SITE1 est accessible' AS Test FROM DUAL@SITE1_LINK;
SELECT 'SITE2 est accessible' AS Test FROM DUAL@SITE2_LINK;















-- -- =========================
-- -- TEST GLOBAL DATABASE
-- -- =========================

-- SELECT * FROM Clients;
-- SELECT * FROM Produits;
-- SELECT * FROM Commandes;
-- SELECT * FROM LigneCommandes;
-- COMMIT;

-- INSERT INTO Clients VALUES (1, 'CLI001', 'Société Atlas');
-- INSERT INTO Clients VALUES (2, 'CLI002', 'Société Omega');
-- INSERT INTO Clients VALUES (3, 'CLI003', 'Société Nova');
-- INSERT INTO Clients VALUES (4, 'CLI004', 'Société Delta');

-- INSERT INTO Produits VALUES (1001, 50, 'Serveur Dell PowerEdge', 20000);
-- INSERT INTO Produits VALUES (1002, 50, 'PC HP Workstation', 12000);
-- INSERT INTO Produits VALUES (2001, 35, 'Clavier Logitech', 300);
-- INSERT INTO Produits VALUES (2002, 35, 'Souris Gaming', 150);
-- INSERT INTO Produits VALUES (2003, 35, 'Écran Samsung 24"', 1800);

-- INSERT INTO Produits VALUES (3001, 50, 'Serveur IBM XSeries', 30000);
-- INSERT INTO Produits VALUES (3002, 50, 'Laptop Lenovo ThinkPad', 15000);
-- INSERT INTO Produits VALUES (4001, 35, 'Casque Audio Sony', 600);
-- INSERT INTO Produits VALUES (4002, 35, 'Webcam HD Logitech', 450);
-- INSERT INTO Produits VALUES (4003, 35, 'Imprimante Epson', 2200);


-- INSERT INTO Commandes VALUES (1, 1, TO_DATE('2026-01-10','YYYY-MM-DD'));
-- INSERT INTO Commandes VALUES (2, 2, TO_DATE('2026-02-15','YYYY-MM-DD'));
-- INSERT INTO Commandes VALUES (3, 3, TO_DATE('2026-03-20','YYYY-MM-DD'));
-- INSERT INTO Commandes VALUES (4, 4, TO_DATE('2026-04-05','YYYY-MM-DD'));

-- INSERT INTO Commandes VALUES (5, 1, TO_DATE('2026-05-01','YYYY-MM-DD'));
-- INSERT INTO Commandes VALUES (6, 2, TO_DATE('2026-05-10','YYYY-MM-DD'));
-- INSERT INTO Commandes VALUES (7, 3, TO_DATE('2026-06-15','YYYY-MM-DD'));
-- INSERT INTO Commandes VALUES (8, 4, TO_DATE('2026-07-20','YYYY-MM-DD'));


-- INSERT INTO LigneCommandes VALUES (1, 1, 1001, 120, 5);
-- INSERT INTO LigneCommandes VALUES (2, 2, 1002, 150, 10);
-- INSERT INTO LigneCommandes VALUES (3, 3, 2001, 20, 0);
-- INSERT INTO LigneCommandes VALUES (4, 4, 2002, 50, 2);
-- INSERT INTO LigneCommandes VALUES (5, 1, 2003, 30, 3);

-- INSERT INTO LigneCommandes VALUES (6, 5, 3001, 200, 10);
-- INSERT INTO LigneCommandes VALUES (7, 6, 3002, 120, 5);
-- INSERT INTO LigneCommandes VALUES (8, 7, 4001, 25, 0);
-- INSERT INTO LigneCommandes VALUES (9, 8, 4002, 40, 3);
-- INSERT INTO LigneCommandes VALUES (10, 9, 4003, 60, 2);

-- INSERT INTO LigneCommandes VALUES (11, 1, 1001, 150, 2);
-- INSERT INTO LigneCommandes VALUES (12, 2, 1002, 100, 5);
-- INSERT INTO LigneCommandes VALUES (13, 3, 3001, 150, 8);
-- INSERT INTO LigneCommandes VALUES (14, 4, 3002, 154, 3);
-- INSERT INTO LigneCommandes VALUES (15, 1, 3001, 145, 4);

-- INSERT INTO LigneCommandes VALUES (16, 5, 2001, 60, 1);
-- INSERT INTO LigneCommandes VALUES (17, 6, 2002, 70, 0);
-- INSERT INTO LigneCommandes VALUES (18, 7, 2003, 80, 2);
-- INSERT INTO LigneCommandes VALUES (19, 8, 4001, 90, 1);
-- INSERT INTO LigneCommandes VALUES (20, 9, 4002, 85, 0);
-- INSERT INTO LigneCommandes
-- VALUES (28, 1, 3001, 121, 5);
-- INSERT INTO LigneCommandes
-- VALUES (23, 12, 2001, 40, 2);
-- INSERT INTO LigneCommandes VALUES (25, 3, 1001, 120, 0);
-- INSERT INTO LigneCommandes
-- VALUES (27, 1, 1001, 120, 5);
-- INSERT INTO LigneCommandes
-- VALUES (29, 1, 1001, 120, 5);
-- COMMIT;

-- SELECT * FROM LigneCommandes1@SITE1_LINK;
-- SELECT * FROM LigneCommandes2@SITE2_LINK;

-- UPDATE LigneCommandes
-- SET quantite = 200,
--     remise = 15
-- WHERE idlignecommande = 1;

-- UPDATE LigneCommandes
-- SET idproduit = 1001,
--     quantite = 300,
--     remise = 5
-- WHERE idlignecommande = 2;

-- DELETE FROM LigneCommandes
-- WHERE idlignecommande = 2;

-- DELETE FROM LigneCommandes
-- WHERE idlignecommande = 5;

-- commit;
-- -- Connexion à la base GLOBALE
-- -- docker exec -it eshop_global_db sqlplus system/oracle@XEPDB1

-- SET SERVEROUTPUT ON;

-- -- Test Globale → Site1
-- BEGIN
--     EXECUTE IMMEDIATE 'SELECT 1 FROM DUAL@SITE1_LINK';
--     DBMS_OUTPUT.PUT_LINE('GLOBALE → SITE1: CONNECTE');
-- EXCEPTION
--     WHEN OTHERS THEN
--         DBMS_OUTPUT.PUT_LINE(' GLOBALE → SITE1: NON CONNECTE - ' || SQLERRM);
-- END;
-- /

-- -- Test Globale → Site2
-- BEGIN
--     EXECUTE IMMEDIATE 'SELECT 1 FROM DUAL@SITE2_LINK';
--     DBMS_OUTPUT.PUT_LINE(' GLOBALE → SITE2: CONNECTE');
-- EXCEPTION
--     WHEN OTHERS THEN
--         DBMS_OUTPUT.PUT_LINE(' GLOBALE → SITE2: NON CONNECTE - ' || SQLERRM);
-- END;
-- /

-- -- Test Globale → Globale (elle-même)
-- BEGIN
--     EXECUTE IMMEDIATE 'SELECT 1 FROM DUAL';
--     DBMS_OUTPUT.PUT_LINE(' GLOBALE → GLOBALE: CONNECTE');
-- EXCEPTION
--     WHEN OTHERS THEN
--         DBMS_OUTPUT.PUT_LINE(' GLOBALE → GLOBALE: NON CONNECTE');
-- END;
-- /
-- SELECT DB_LINK, USERNAME, HOST, CREATED 
-- FROM ALL_DB_LINKS;

-- -- Vérification avec requêtes directes
-- SELECT 'Globale → Site1 OK' as Test FROM DUAL@SITE1_LINK;
-- SELECT 'Globale → Site2 OK' as Test FROM DUAL@SITE2_LINK;

-- BEGIN

--     DELETE FROM LigneCommandes;
--     DELETE FROM Commandes;
--     DELETE FROM Produits;
--     DELETE FROM Clients;

--     COMMIT;

--     DBMS_OUTPUT.PUT_LINE(
--         'Toutes les données ont été supprimées.'
--     );

-- EXCEPTION
--     WHEN OTHERS THEN

--         ROLLBACK;

--         DBMS_OUTPUT.PUT_LINE(
--             'Erreur : ' || SQLERRM
--         );

-- END;
-- /
-- DROP TABLE Clients;
-- DROP TABLE Produits;
-- DROP TABLE Commandes;
-- DROP TABLE LigneCommande;
-- DROP TABLE LigneCommandes CASCADE CONSTRAINTS;
-- -- DROP TABLE Commandes CASCADE CONSTRAINTS;
-- -- DROP TABLE Produits CASCADE CONSTRAINTS;
-- -- DROP TABLE Clients CASCADE CONSTRAINTS;
-- BEGIN

--     EXECUTE IMMEDIATE 'DROP TABLE Clients';
--     DBMS_OUTPUT.PUT_LINE('Table Clients supprimée.');

-- EXCEPTION
--     WHEN OTHERS THEN
--         DBMS_OUTPUT.PUT_LINE(
--             'Erreur suppression Clients : ' || SQLERRM
--         );
-- END;
-- /

-- BEGIN

--     EXECUTE IMMEDIATE 'DROP TABLE Produits';
--     DBMS_OUTPUT.PUT_LINE('Table Produits supprimée.');

-- EXCEPTION
--     WHEN OTHERS THEN
--         DBMS_OUTPUT.PUT_LINE(
--             'Erreur suppression Produits : ' || SQLERRM
--         );
-- END;
-- /

-- BEGIN

--     EXECUTE IMMEDIATE 'DROP TABLE Commandes';
--     DBMS_OUTPUT.PUT_LINE('Table Commandes supprimée.');

-- EXCEPTION
--     WHEN OTHERS THEN
--         DBMS_OUTPUT.PUT_LINE(
--             'Erreur suppression Commandes : ' || SQLERRM
--         );
-- END;
-- /

-- BEGIN

--     EXECUTE IMMEDIATE 'DROP TABLE LigneCommande';
--     DBMS_OUTPUT.PUT_LINE('Table LigneCommande supprimée.');

-- EXCEPTION
--     WHEN OTHERS THEN
--         DBMS_OUTPUT.PUT_LINE(
--             'Erreur suppression LigneCommande : ' || SQLERRM
--         );
-- END;
-- /
-- BEGIN

--     EXECUTE IMMEDIATE 'DROP TABLE LigneCommande';

--     DBMS_OUTPUT.PUT_LINE(
--         'Table LigneCommande supprimée.'
--     );

-- EXCEPTION
--     WHEN OTHERS THEN

--         IF SQLCODE = -942 THEN

--             DBMS_OUTPUT.PUT_LINE(
--                 'La table LigneCommande n''existe pas.'
--             );

--         ELSE

--             DBMS_OUTPUT.PUT_LINE(
--                 'Erreur suppression LigneCommande : '
--                 || SQLERRM
--             );

--         END IF;

-- END;
-- /
-- BEGIN
--    INSERTLIGNE1@SITE1_LINK(1,1,1,1,1);
-- END;
-- /
-- SELECT * FROM dual@SITE1_LINK;
-- SELECT * FROM dual@SITE2_LINK;
-- DROP DATABASE LINK SITE2_LINK;
-- CREATE DATABASE LINK SITE1_LINK
-- CONNECT TO system IDENTIFIED BY oracle
-- USING '(DESCRIPTION=
--   (ADDRESS=(PROTOCOL=TCP)(HOST=eshop_site1_db)(PORT=1521))
--   (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
-- )';
-- CREATE DATABASE LINK SITE2_LINK
-- CONNECT TO system IDENTIFIED BY oracle
-- USING '(DESCRIPTION=
--   (ADDRESS=(PROTOCOL=TCP)(HOST=eshop_site2_db)(PORT=1521))
--   (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
-- )';