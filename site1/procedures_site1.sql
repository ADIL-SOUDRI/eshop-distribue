-- =========================================
--  PROCÉDURES SITE 1
-- Table : LigneCommandes1
-- Objectif : INSERT / DELETE / UPDATE

-- =========================================



-- =========================================
--  INSERTION
-- Ajoute une ligne dans LigneCommandes1
-- =========================================
CREATE OR REPLACE PROCEDURE insertligne1(
    p_idlignecommande NUMBER,
    p_idcommande NUMBER,
    p_idproduit NUMBER,
    p_quantite NUMBER,
    p_remise NUMBER
)
IS
BEGIN
    INSERT INTO LigneCommandes1
    VALUES (p_idlignecommande, p_idcommande, p_idproduit, p_quantite, p_remise);
END;
/
-- =========================================



-- =========================================
-- SUPPRESSION
-- Supprime une ligne selon ID
-- =========================================
CREATE OR REPLACE PROCEDURE deleteligne1(
    p_idlignecommande NUMBER
)
IS
BEGIN
    DELETE FROM LigneCommandes1
    WHERE idlignecommande = p_idlignecommande;
END;
/
-- =========================================



-- =========================================
-- MODIFICATION
-- Met à jour une ligne existante
-- =========================================
CREATE OR REPLACE PROCEDURE updateligne1(
    p_idlignecommande NUMBER,
    p_idproduit NUMBER,
    p_quantite NUMBER,
    p_remise NUMBER
)
IS
BEGIN
    UPDATE LigneCommandes1
    SET idproduit = p_idproduit,
        quantite = p_quantite,
        remise = p_remise
    WHERE idlignecommande = p_idlignecommande;
END;
/
-- =========================================


SELECT object_name FROM user_objects WHERE object_type='PROCEDURE';
-- =========================================
-- TESTS INTERNES DU FICHIER
-- À exécuter après création des procédures
-- =========================================

-- TEST INSERT
BEGIN
    insertligne1(1, 10, 1001, 120, 5);
END;
/

-- Vérification INSERT
SELECT * FROM LigneCommandes1
WHERE idlignecommande = 1;



-- TEST UPDATE
BEGIN
    updateligne1(1, 1002, 200, 10);
END;
/

-- Vérification UPDATE
SELECT * FROM LigneCommandes1
WHERE idlignecommande = 1;



--  TEST DELETE
BEGIN
    deleteligne1(1);
END;
/

-- Vérification DELETE
SELECT * FROM LigneCommandes1
WHERE idlignecommande = 1;



-- =========================================
--  TEST FRAGMENTATION (SITE1)
-- règle : quantite > 100
-- =========================================

SELECT * FROM LigneCommandes1
WHERE quantite <= 100;

-- Résultat attendu : VIDE
-- =========================================

-- CREATE OR REPLACE PROCEDURE insertligne1(
--     p_idlignecommande NUMBER,
--     p_idcommande NUMBER,
--     p_idproduit NUMBER,
--     p_quantite NUMBER,
--     p_remise NUMBER
-- )
-- IS
-- BEGIN
--     INSERT INTO LigneCommandes1
--     VALUES (p_idlignecommande, p_idcommande, p_idproduit, p_quantite, p_remise);
-- END;
-- /
-- CREATE OR REPLACE PROCEDURE deleteligne1(
--     p_idlignecommande NUMBER
-- )
-- IS
-- BEGIN
--     DELETE FROM LigneCommandes1
--     WHERE idlignecommande = p_idlignecommande;
-- END;
-- /
-- CREATE OR REPLACE PROCEDURE updateligne1(
--     p_idlignecommande NUMBER,
--     p_idproduit NUMBER,
--     p_quantite NUMBER,
--     p_remise NUMBER
-- )
-- IS
-- BEGIN
--     UPDATE LigneCommandes1
--     SET idproduit = p_idproduit,
--         quantite = p_quantite,
--         remise = p_remise
--     WHERE idlignecommande = p_idlignecommande;
-- END;
-- /
-- -- BEGIN
-- --     insertligne1(1, 10, 1001, 120, 5);
-- -- END;
-- -- /

-- -- SELECT * FROM LigneCommandes1
-- -- WHERE idlignecommande = 1;