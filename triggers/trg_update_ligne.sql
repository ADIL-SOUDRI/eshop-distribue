CREATE OR REPLACE TRIGGER SYC_UPDATE_LIGNE
AFTER UPDATE ON LigneCommandes
FOR EACH ROW

DECLARE
   v_cat NUMBER;

BEGIN

   -- récupérer la catégorie du produit
   SELECT idcateg
   INTO v_cat
   FROM Produits
   WHERE idproduit = :NEW.idproduit;

   -- =========================================
   -- CAS SITE 1 (catégorie 50 et quantité >= 100)
   -- =========================================
   IF v_cat = 50 AND :NEW.quantite >= 100 THEN

      UPDATELIGNE1@SITE1_LINK(
         :NEW.idlignecommande,
         :NEW.idproduit,
         :NEW.quantite,
         :NEW.remise
      );

   -- =========================================
   -- CAS SITE 2 (catégorie 35 et quantité < 100)
   -- =========================================
   ELSIF v_cat = 35 AND :NEW.quantite < 100 THEN

      UPDATELIGNE2@SITE2_LINK(
         :NEW.idlignecommande,
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
--     v_cat Produits.idcateg%TYPE;
-- BEGIN

--     SELECT idcateg
--     INTO v_cat
--     FROM Produits
--     WHERE idproduit = :NEW.idproduit;

--     IF v_cat = 50 THEN

--         UPDATE LigneCommandes1
--         SET
--             idproduit = :NEW.idproduit,
--             quantite = :NEW.quantite,
--             remise = :NEW.remise
--         WHERE idlignecommande = :NEW.idlignecommande;

--     ELSIF v_cat = 35 THEN

--         UPDATE LigneCommandes2@site2
--         SET
--             idproduit = :NEW.idproduit,
--             quantite = :NEW.quantite,
--             remise = :NEW.remise
--         WHERE idlignecommande = :NEW.idlignecommande;

--     END IF;

-- END;
-- /
UPDATE LigneCommandes
SET quantite = 150
WHERE idlignecommande = 1;