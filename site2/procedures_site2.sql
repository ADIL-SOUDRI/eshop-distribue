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
    v_count NUMBER;
    v_idclient NUMBER;
    v_categ NUMBER;

BEGIN

    --  récupérer catégorie produit
    SELECT idcateg
    INTO v_categ
    FROM Produits@site_global
    WHERE idproduit = p_idproduit;

    --  CONTRÔLE SITE2 (ex: catégorie 35)
    IF v_categ != 35 THEN
        RAISE_APPLICATION_ERROR(-20031,
        'Erreur: Produit ' || p_idproduit || ' non autorisé pour Site 2');
    END IF;

    --  CONTRÔLE QUANTITÉ SITE2
    IF p_quantite >= 100 THEN
        RAISE_APPLICATION_ERROR(-20032,
        'Erreur: Quantité invalide (' || p_quantite || ') doit être < 100');
    END IF;

    -- récupérer client
    SELECT idclient
    INTO v_idclient
    FROM Commandes@site_global
    WHERE idcommande = p_idcommande;

    -- CLIENTS2
    SELECT COUNT(*) INTO v_count FROM Clients2 WHERE idclient = v_idclient;
    IF v_count = 0 THEN
        INSERT INTO Clients2
        SELECT * FROM Clients@site_global WHERE idclient = v_idclient;
    END IF;

    -- PRODUITS2
    SELECT COUNT(*) INTO v_count FROM Produits2 WHERE idproduit = p_idproduit;
    IF v_count = 0 THEN
        INSERT INTO Produits2
        SELECT * FROM Produits@site_global WHERE idproduit = p_idproduit;
    END IF;

    -- COMMANDES2
    SELECT COUNT(*) INTO v_count FROM Commandes2 WHERE idcommande = p_idcommande;
    IF v_count = 0 THEN
        INSERT INTO Commandes2
        SELECT * FROM Commandes@site_global WHERE idcommande = p_idcommande;
    END IF;

    -- LIGNE
    INSERT INTO LigneCommandes2
    VALUES (p_idlignecommande, p_idcommande, p_idproduit, p_quantite, p_remise);

    DBMS_OUTPUT.PUT_LINE('Insertion réussie SITE 2 : ' || p_idlignecommande);

EXCEPTION

    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('[ERREUR] Données inexistantes dans le global.');

    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('[ERREUR] Ligne déjà existante.');

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('[ERREUR] Problème technique SITE 2.');
END;
/
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
-- =========================================



-- =========================================
--  SUPPRESSION
-- Supprime une ligne selon ID
-- =========================================
CREATE OR REPLACE PROCEDURE deleteligne2(
    p_idlignecommande NUMBER
)
IS
    v_count NUMBER;

BEGIN

    -- vérifier existence
    SELECT COUNT(*)
    INTO v_count
    FROM LigneCommandes2
    WHERE idlignecommande = p_idlignecommande;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20040,
        'Erreur: ligne inexistante Site2');
    END IF;

    -- suppression
    DELETE FROM LigneCommandes2
    WHERE idlignecommande = p_idlignecommande;

    DBMS_OUTPUT.PUT_LINE('Suppression réussie Site2 : ' || p_idlignecommande);

EXCEPTION

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('[ERREUR] suppression Site2 impossible');
END;
/

-- CREATE OR REPLACE PROCEDURE deleteligne2(
--     p_idlignecommande NUMBER
-- )
-- IS
-- BEGIN
--     DELETE FROM LigneCommandes2
--     WHERE idlignecommande = p_idlignecommande;
-- END;
-- /
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
    v_count NUMBER;
    v_categ NUMBER;

BEGIN

    -- vérifier existence
    SELECT COUNT(*)
    INTO v_count
    FROM LigneCommandes2
    WHERE idlignecommande = p_idlignecommande;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20050,
        'Erreur: ligne inexistante Site2');
    END IF;

    -- catégorie produit
    SELECT idcateg
    INTO v_categ
    FROM Produits@site_global
    WHERE idproduit = p_idproduit;

    -- contrôle Site2
    IF v_categ != 35 THEN
        RAISE_APPLICATION_ERROR(-20051,
        'Erreur: produit non autorisé Site2');
    END IF;

    IF p_quantite >= 100 THEN
        RAISE_APPLICATION_ERROR(-20052,
        'Erreur: quantité doit être < 100');
    END IF;

    -- update
    UPDATE LigneCommandes2
    SET idproduit = p_idproduit,
        quantite = p_quantite,
        remise = p_remise
    WHERE idlignecommande = p_idlignecommande;

    DBMS_OUTPUT.PUT_LINE('Update réussi Site2 : ' || p_idlignecommande);

EXCEPTION

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('[ERREUR] update Site2 échoué');
END;
/
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
-- =========================================



-- =========================================
--  TESTS INTERNES DU FICHIER
-- À exécuter après compilation des procédures
-- =========================================

--  TEST INSERT
BEGIN
    insertligne2(30,1, 2001, 10, 5);
END;
/
COMMIt;

-- Vérification INSERT
SELECT * FROM LigneCommandes2
WHERE idlignecommande = 30;



--  TEST UPDATE
BEGIN
    updateligne2(30, 2002, 10, 10);
END;
/
COMMIt;

-- Vérification UPDATE
SELECT * FROM LigneCommandes2
WHERE idlignecommande = 30;



--  TEST DELETE
BEGIN
    deleteligne2(30);
END;
/
COMMIt;

-- Vérification DELETE
SELECT * FROM LigneCommandes2
WHERE idlignecommande = 30;



-- =========================================
--  TEST FRAGMENTATION SITE2
-- règle : quantite > 50
-- =========================================

SELECT * FROM LigneCommandes2
WHERE quantite >=100;

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