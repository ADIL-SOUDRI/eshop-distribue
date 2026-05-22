-- =========================================
--  PROCÉDURES SITE 2
-- Table : LigneCommandes2
-- Objectif : INSERT / DELETE / UPDATE

-- =========================================



-- =========================================
--  INSERTION
-- Ajoute une ligne dans LigneCommandes2
-- =========================================
CREATE OR REPLACE PROCEDURE insertligne2(
    p_idlignecommande NUMBER,
    p_idcommande NUMBER,
    p_idproduit NUMBER,
    p_quantite NUMBER,
    p_remise NUMBER
)
IS
BEGIN
    INSERT INTO LigneCommandes2
    VALUES (p_idlignecommande, p_idcommande, p_idproduit, p_quantite, p_remise);
END;
/
-- =========================================



-- =========================================
--  SUPPRESSION
-- Supprime une ligne selon ID
-- =========================================
CREATE OR REPLACE PROCEDURE deleteligne2(
    p_idlignecommande NUMBER
)
IS
BEGIN
    DELETE FROM LigneCommandes2
    WHERE idlignecommande = p_idlignecommande;
END;
/
-- =========================================



-- =========================================
--  MODIFICATION
-- Met à jour une ligne existante
-- =========================================
CREATE OR REPLACE PROCEDURE updateligne2(
    p_idlignecommande NUMBER,
    p_idproduit NUMBER,
    p_quantite NUMBER,
    p_remise NUMBER
)
IS
BEGIN
    UPDATE LigneCommandes2
    SET idproduit = p_idproduit,
        quantite = p_quantite,
        remise = p_remise
    WHERE idlignecommande = p_idlignecommande;
END;
/
-- =========================================



-- =========================================
--  TESTS INTERNES DU FICHIER
-- À exécuter après compilation des procédures
-- =========================================

--  TEST INSERT
BEGIN
    insertligne2(1, 20, 2001, 80, 5);
END;
/

-- Vérification INSERT
SELECT * FROM LigneCommandes2
WHERE idlignecommande = 1;



--  TEST UPDATE
BEGIN
    updateligne2(1, 2002, 150, 10);
END;
/

-- Vérification UPDATE
SELECT * FROM LigneCommandes2
WHERE idlignecommande = 1;



--  TEST DELETE
BEGIN
    deleteligne2(1);
END;
/

-- Vérification DELETE
SELECT * FROM LigneCommandes2
WHERE idlignecommande = 1;



-- =========================================
--  TEST FRAGMENTATION SITE2
-- règle : quantite > 50
-- =========================================

SELECT * FROM LigneCommandes2
WHERE quantite <= 50;

--  Résultat attendu : VIDE
-- =========================================

-- CREATE OR REPLACE PROCEDURE insertligne2(
--     p_idlignecommande NUMBER,
--     p_idcommande NUMBER,
--     p_idproduit NUMBER,
--     p_quantite NUMBER,
--     p_remise NUMBER
-- )
-- IS
-- BEGIN
--     INSERT INTO LigneCommandes2
--     VALUES (p_idlignecommande, p_idcommande, p_idproduit, p_quantite, p_remise);
-- END;
-- /
-- CREATE OR REPLACE PROCEDURE deleteligne2(
--     p_idlignecommande NUMBER
-- )
-- IS
-- BEGIN
--     DELETE FROM LigneCommandes2
--     WHERE idlignecommande = p_idlignecommande;
-- END;
-- /
-- CREATE OR REPLACE PROCEDURE updateligne2(
--     p_idlignecommande NUMBER,
--     p_idproduit NUMBER,
--     p_quantite NUMBER,
--     p_remise NUMBER
-- )
-- IS
-- BEGIN
--     UPDATE LigneCommandes2
--     SET idproduit = p_idproduit,
--         quantite = p_quantite,
--         remise = p_remise
--     WHERE idlignecommande = p_idlignecommande;
-- END;
-- /