CREATE OR REPLACE TRIGGER SYC_UPDATE_LIGNE
AFTER UPDATE ON LigneCommandes
FOR EACH ROW

DECLARE
    v_old_cat NUMBER;
    v_new_cat NUMBER;

    v_old_site NUMBER;
    v_new_site NUMBER;

BEGIN

    -- Catégorie AVANT modification
    SELECT idcateg
    INTO v_old_cat
    FROM Produits
    WHERE idproduit = :OLD.idproduit;

    -- Catégorie APRÈS modification
    SELECT idcateg
    INTO v_new_cat
    FROM Produits
    WHERE idproduit = :NEW.idproduit;

    -- Déterminer ancien site
    IF v_old_cat = 50 AND :OLD.quantite >= 100 THEN
        v_old_site := 1;
    ELSIF v_old_cat = 35 AND :OLD.quantite < 100 AND :OLD.quantite > 50 THEN
        v_old_site := 2;
    END IF;

    -- Déterminer nouveau site
    IF v_new_cat = 50 AND :NEW.quantite >= 100 THEN
        v_new_site := 1;
    ELSIF v_new_cat = 35 AND :NEW.quantite < 100 AND :NEW.quantite > 50 THEN
        v_new_site := 2;
    END IF;

    -- =========================================
    -- Même site : UPDATE
    -- =========================================

    IF v_old_site = 1 AND v_new_site = 1 THEN

        UPDATELIGNE1@SITE1_LINK(
            :NEW.idlignecommande,
            :NEW.idproduit,
            :NEW.quantite,
            :NEW.remise
        );

    ELSIF v_old_site = 2 AND v_new_site = 2 THEN

        UPDATELIGNE2@SITE2_LINK(
            :NEW.idlignecommande,
            :NEW.idproduit,
            :NEW.quantite,
            :NEW.remise
        );

    -- =========================================
    -- Migration Site1 -> Site2
    -- =========================================

    ELSIF v_old_site = 1 AND v_new_site = 2 THEN

        DELETELIGNE1@SITE1_LINK(
            :OLD.idlignecommande
        );

        INSERTLIGNE2@SITE2_LINK(
            :NEW.idlignecommande,
            :NEW.idcommande,
            :NEW.idproduit,
            :NEW.quantite,
            :NEW.remise
        );

    -- =========================================
    -- Migration Site2 -> Site1
    -- =========================================

    ELSIF v_old_site = 2 AND v_new_site = 1 THEN

        DELETELIGNE2@SITE2_LINK(
            :OLD.idlignecommande
        );

        INSERTLIGNE1@SITE1_LINK(
            :NEW.idlignecommande,
            :NEW.idcommande,
            :NEW.idproduit,
            :NEW.quantite,
            :NEW.remise
        );

    END IF;

END;
/

-- CREATE OR REPLACE TRIGGER SYC_UPDATE_LIGNE
-- AFTER UPDATE ON LigneCommandes
-- FOR EACH ROW

-- DECLARE
--    v_cat NUMBER;

-- BEGIN

--    -- récupérer la catégorie du produit
--    SELECT idcateg
--    INTO v_cat
--    FROM Produits
--    WHERE idproduit = :NEW.idproduit;

--    -- =========================================
--    -- CAS SITE 1 (catégorie 50 et quantité >= 100)
--    -- =========================================
--    IF v_cat = 50 AND :NEW.quantite >= 100 THEN

--       UPDATELIGNE1@SITE1_LINK(
--          :NEW.idlignecommande,
--          :NEW.idproduit,
--          :NEW.quantite,
--          :NEW.remise
--       );

--    -- =========================================
--    -- CAS SITE 2 (catégorie 35 et quantité < 100)
--    -- =========================================
--    ELSIF v_cat = 35 AND  :NEW.quantite < 100 AND :NEW.quantite >50 THEN

--       UPDATELIGNE2@SITE2_LINK(
--          :NEW.idlignecommande,
--          :NEW.idproduit,
--          :NEW.quantite,
--          :NEW.remise
--       );

--    END IF;

-- END;
-- /


-- -- CREATE OR REPLACE TRIGGER SYC_UPDATE_LIGNE
-- -- AFTER UPDATE ON LigneCommandes
-- -- FOR EACH ROW
-- -- DECLARE
-- --     v_cat Produits.idcateg%TYPE;
-- -- BEGIN

-- --     SELECT idcateg
-- --     INTO v_cat
-- --     FROM Produits
-- --     WHERE idproduit = :NEW.idproduit;

-- --     IF v_cat = 50 THEN

-- --         UPDATE LigneCommandes1
-- --         SET
-- --             idproduit = :NEW.idproduit,
-- --             quantite = :NEW.quantite,
-- --             remise = :NEW.remise
-- --         WHERE idlignecommande = :NEW.idlignecommande;

-- --     ELSIF v_cat = 35 THEN

-- --         UPDATE LigneCommandes2@site2
-- --         SET
-- --             idproduit = :NEW.idproduit,
-- --             quantite = :NEW.quantite,
-- --             remise = :NEW.remise
-- --         WHERE idlignecommande = :NEW.idlignecommande;

-- --     END IF;

-- -- END;
-- -- /
-- UPDATE LigneCommandes
-- SET quantite = 150
-- WHERE idlignecommande = 1;