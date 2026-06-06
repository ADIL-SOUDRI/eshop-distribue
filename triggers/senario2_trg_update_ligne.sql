CREATE OR REPLACE TRIGGER SYC_UPDATE_LIGNE_SC2
AFTER UPDATE ON LigneCommandes
FOR EACH ROW
BEGIN

   -- Site1 -> Site1
   IF :OLD.quantite >= 100 AND :NEW.quantite >= 100 THEN

      updateligne1_scenario2@SITE1_LINK(
          :NEW.idlignecommande,
          :NEW.idproduit,
          :NEW.quantite,
          :NEW.remise
      );

   -- Site2 -> Site2
   ELSIF :OLD.quantite < 100 AND :NEW.quantite < 100 THEN

      updateligne2_scenario2@SITE2_LINK(
          :NEW.idlignecommande,
          :NEW.idproduit,
          :NEW.quantite,
          :NEW.remise
      );

   -- Site1 -> Site2
   ELSIF :OLD.quantite >= 100 AND :NEW.quantite < 100 THEN

      deleteligne1_scenario2@SITE1_LINK(
          :OLD.idlignecommande
      );

      insertligne2_scenario2@SITE2_LINK(
          :NEW.idlignecommande,
          :NEW.idcommande,
          :NEW.idproduit,
          :NEW.quantite,
          :NEW.remise
      );

   -- Site2 -> Site1
   ELSIF :OLD.quantite < 100 AND :NEW.quantite >= 100 THEN

      deleteligne2_scenario2@SITE2_LINK(
          :OLD.idlignecommande
      );

      insertligne1_scenario2@SITE1_LINK(
          :NEW.idlignecommande,
          :NEW.idcommande,
          :NEW.idproduit,
          :NEW.quantite,
          :NEW.remise
      );

   END IF;

END;
/