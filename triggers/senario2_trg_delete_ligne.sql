CREATE OR REPLACE TRIGGER SYC_DELETE_LIGNE_SC2
AFTER DELETE ON LigneCommandes
FOR EACH ROW
DECLARE
   v_quantite NUMBER;
BEGIN

   -- récupérer la quantité supprimée
   v_quantite := :OLD.quantite;

   -- =========================================
   -- CAS SITE 1 (quantité >= 100)
   -- =========================================
   IF v_quantite >= 100 THEN

      DELETELIGNE1_SCENARIO2@SITE1_LINK(
         :OLD.idlignecommande
      );

   -- =========================================
   -- CAS SITE 2 (quantité < 100)
   -- =========================================
   ELSIF v_quantite < 100 THEN

      DELETELIGNE2_SCENARIO2@SITE2_LINK(
         :OLD.idlignecommande
      );

   END IF;

END;
/