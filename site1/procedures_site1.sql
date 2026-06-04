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
    v_count NUMBER;
    v_idclient NUMBER;
    v_categ NUMBER;
    
    -- 1. On déclare des exceptions personnalisées pour lier nos codes erreurs
    exception_categorie EXCEPTION;
    PRAGMA EXCEPTION_INIT(exception_categorie, -20001);
    
    exception_quantite EXCEPTION;
    PRAGMA EXCEPTION_INIT(exception_quantite, -20002);
BEGIN
    -- Récupérer catégorie produit (GLOBAL)
    SELECT idcateg INTO v_categ
    FROM Produits@site_global
    WHERE idproduit = p_idproduit;

    -- CONTRÔLE SITE1 : Catégorie
    IF v_categ != 50 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Erreur: Produit ' || p_idproduit || ' (catégorie ≠ 50)');
    END IF;

    -- CONTRÔLE SITE1 : Quantité
    IF p_quantite <= 100 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Erreur: Quantité invalide (' || p_quantite || '), doit être > 100');
    END IF;

    -- Récupérer client depuis SITE GLOBAL
    SELECT idclient INTO v_idclient
    FROM Commandes@site_global
    WHERE idcommande = p_idcommande;

    -- CLIENTS1 (Vérification et insertion locale)
    SELECT COUNT(*) INTO v_count FROM Clients1 WHERE idclient = v_idclient;
    IF v_count = 0 THEN
        INSERT INTO Clients1 SELECT * FROM Clients@site_global WHERE idclient = v_idclient;
    END IF;

    -- PRODUITS1 (Vérification et insertion locale)
    SELECT COUNT(*) INTO v_count FROM Produits1 WHERE idproduit = p_idproduit;
    IF v_count = 0 THEN
        INSERT INTO Produits1 SELECT * FROM Produits@site_global WHERE idproduit = p_idproduit;
    END IF;

    -- COMMANDES1 (Vérification et insertion locale)
    SELECT COUNT(*) INTO v_count FROM Commandes1 WHERE idcommande = p_idcommande;
    IF v_count = 0 THEN
        INSERT INTO Commandes1 SELECT * FROM Commandes@site_global WHERE idcommande = p_idcommande;
    END IF;

    -- INSERTION FINALE DE LA LIGNE
    INSERT INTO LigneCommandes1 VALUES (p_idlignecommande, p_idcommande, p_idproduit, p_quantite, p_remise);
    
    DBMS_OUTPUT.PUT_LINE(' Insertion réussie sur le SITE 1 pour la ligne : ' || p_idlignecommande);

EXCEPTION
    -- Capture de l'erreur catégorie (Bloqué par le contrôle)
    WHEN exception_categorie THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [STOP] Cette catégorie n''appartient pas au Site 1.');

    -- Capture de l'erreur quantité (Bloqué par le contrôle)
    WHEN exception_quantite THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [STOP] Quantité insuffisante pour le Site 1 (doit être > 100).');

    -- Capture si le produit ou la commande n'existe pas du tout sur @site_global
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [ERREUR] Le produit ' || p_idproduit || ' ou la commande ' || p_idcommande || ' n''existe pas dans la base globale.');

    -- Capture des clés dupliquées (ex: idlignecommande existe déjà)
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [ERREUR] Impossible d''insérer. L''identifiant de ligne ' || p_idlignecommande || ' existe déjà.');

    -- Toutes les autres erreurs inconnues
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [ERREUR INCONNUE] Une erreur réseau ou technique est survenue.');
END;
/
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
-- =========================================



-- =========================================
-- SUPPRESSION
-- Supprime une ligne selon ID
-- =========================================
CREATE OR REPLACE PROCEDURE deleteligne1(
    p_idlignecommande NUMBER
)
IS
    v_count NUMBER;

    -- Exception personnalisée
    exception_not_found EXCEPTION;
    PRAGMA EXCEPTION_INIT(exception_not_found, -20010);

BEGIN

    -- Vérifier existence
    SELECT COUNT(*)
    INTO v_count
    FROM LigneCommandes1
    WHERE idlignecommande = p_idlignecommande;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
        'Erreur: ligne ' || p_idlignecommande || ' inexistante');
    END IF;

    -- Suppression
    DELETE FROM LigneCommandes1
    WHERE idlignecommande = p_idlignecommande;

    DBMS_OUTPUT.PUT_LINE(' Suppression réussie de la ligne : ' || p_idlignecommande);

EXCEPTION

    WHEN exception_not_found THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [STOP] La ligne ' || p_idlignecommande || ' n''existe pas dans Site 1.');

    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [ERREUR] Une erreur technique est survenue lors de la suppression.');
END;
/


-- CREATE OR REPLACE PROCEDURE deleteligne1(
--     p_idlignecommande NUMBER
-- )
-- IS
-- BEGIN
--     DELETE FROM LigneCommandes1
--     WHERE idlignecommande = p_idlignecommande;
-- END;
-- /
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
    v_count NUMBER;
    v_categ NUMBER;

    -- Exceptions personnalisées
    exception_not_found EXCEPTION;
    PRAGMA EXCEPTION_INIT(exception_not_found, -20020);

    exception_quantite EXCEPTION;
    PRAGMA EXCEPTION_INIT(exception_quantite, -20021);

    exception_categorie EXCEPTION;
    PRAGMA EXCEPTION_INIT(exception_categorie, -20022);

BEGIN

    -- Vérifier existence ligne
    SELECT COUNT(*)
    INTO v_count
    FROM LigneCommandes1
    WHERE idlignecommande = p_idlignecommande;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20020,
        'Erreur: ligne ' || p_idlignecommande || ' inexistante');
    END IF;

    -- Récupérer catégorie produit
    SELECT idcateg
    INTO v_categ
    FROM Produits@site_global
    WHERE idproduit = p_idproduit;

    -- Contrôle catégorie Site1
    IF v_categ != 50 THEN
        RAISE_APPLICATION_ERROR(-20022,
        'Erreur: Produit ' || p_idproduit || ' non autorisé (catégorie ≠ 50)');
    END IF;

    -- Contrôle quantité Site1
    IF p_quantite <= 100 THEN
        RAISE_APPLICATION_ERROR(-20021,
        'Erreur: Quantité invalide (' || p_quantite || ') doit être > 100');
    END IF;

    -- Mise à jour
    UPDATE LigneCommandes1
    SET idproduit = p_idproduit,
        quantite = p_quantite,
        remise = p_remise
    WHERE idlignecommande = p_idlignecommande;

    DBMS_OUTPUT.PUT_LINE(' Mise à jour réussie de la ligne : ' || p_idlignecommande);

EXCEPTION

    WHEN exception_not_found THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [STOP] La ligne ' || p_idlignecommande || ' n''existe pas.');

    WHEN exception_quantite THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [STOP] Quantité insuffisante pour Site 1 (doit être > 100).');

    WHEN exception_categorie THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [STOP] Produit non autorisé pour Site 1.');

    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [ERREUR] Produit introuvable dans la base globale.');

    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [ERREUR] Problème technique lors de la mise à jour.');
END;
/


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
-- =========================================


SELECT object_name FROM user_objects WHERE object_type='PROCEDURE';
-- =========================================
-- TESTS INTERNES DU FICHIER
-- À exécuter après création des procédures
-- =========================================

-- TEST INSERT
BEGIN
    insertligne1(28, 155, 1001, 156, 5);
END;
/
COMMIT;
-- Vérification INSERT
SELECT * FROM LigneCommandes1
WHERE idlignecommande = 28;



-- TEST UPDATE
BEGIN
    updateligne1(28, 1001, 300, 10);
END;
/
COMMIT;

-- Vérification UPDATE
SELECT * FROM LigneCommandes1
WHERE idlignecommande = 28;



--  TEST DELETE
BEGIN
    deleteligne1(28);
END;
/
Commit;
-- Vérification DELETE
SELECT * FROM LigneCommandes1
WHERE idlignecommande = 28;



-- =========================================
--  TEST FRAGMENTATION (SITE1)
-- règle : quantite > 100
-- =========================================

SELECT * FROM LigneCommandes1
WHERE quantite < 100;

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