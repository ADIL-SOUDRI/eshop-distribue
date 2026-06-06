CREATE OR REPLACE TRIGGER SYC_INSERT_LIGNE_SC2
AFTER INSERT ON LigneCommandes
FOR EACH ROW

DECLARE
   v_quantite NUMBER;

BEGIN
   -- Récupérer la quantité insérée
   v_quantite := :NEW.quantite;

   -- Site1 : Gros volumes (quantité >= 100)
   IF v_quantite >= 100 THEN
      
      INSERTLIGNE1_SCENARIO2@SITE1_LINK(
         :NEW.idlignecommande,
         :NEW.idcommande,
         :NEW.idproduit,
         :NEW.quantite,
         :NEW.remise
      );

   -- Site2 : Petits volumes (quantité < 100)
   ELSIF v_quantite < 100 THEN

      INSERTLIGNE2_SCENARIO2@SITE2_LINK(
         :NEW.idlignecommande,
         :NEW.idcommande,
         :NEW.idproduit,
         :NEW.quantite,
         :NEW.remise
      );

   END IF;

EXCEPTION
   WHEN OTHERS THEN
      -- Log l'erreur mais ne bloque pas l'insertion globale
      DBMS_OUTPUT.PUT_LINE('Erreur insertion distribuée: ' || SQLERRM);
      RAISE;
END;
/