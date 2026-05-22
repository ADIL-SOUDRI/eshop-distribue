CREATE OR REPLACE TRIGGER SYC_DELETE_LIGNE
AFTER DELETE ON LigneCommandes
FOR EACH ROW

DECLARE
   v_cat NUMBER;

BEGIN

   -- récupérer la catégorie du produit supprimé
   SELECT idcateg
   INTO v_cat
   FROM Produits
   WHERE idproduit = :OLD.idproduit;

   -- =========================================
   -- CAS SITE 1 (catégorie 50)
   -- =========================================
   IF v_cat = 50 THEN

      DELETELIGNE1@SITE1_LINK(
         :OLD.idlignecommande
      );

   -- =========================================
   -- CAS SITE 2 (catégorie 35)
   -- =========================================
   ELSIF v_cat = 35 THEN

      DELETELIGNE2@SITE2_LINK(
         :OLD.idlignecommande
      );

   END IF;

END;
/

-- CREATE OR REPLACE TRIGGER SYC_DELETE_LIGNE
-- AFTER DELETE ON LigneCommandes
-- FOR EACH ROW
-- DECLARE
--     cat Produits.idcateg%TYPE;
-- BEGIN

--     SELECT idcateg
--     INTO cat
--     FROM Produits
--     WHERE idproduit = :OLD.idproduit;

--     IF cat = 50 THEN

--         DELETE FROM LigneCommandes1
--         WHERE idlignecommande = :OLD.idlignecommande;

--     ELSIF cat = 35 THEN

--         DELETE FROM LigneCommandes2@site2
--         WHERE idlignecommande = :OLD.idlignecommande;

--     END IF;

-- END;


