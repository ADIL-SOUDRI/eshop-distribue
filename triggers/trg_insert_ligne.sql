CREATE OR REPLACE TRIGGER SYC_INSERT_LIGNE
AFTER INSERT ON LigneCommandes
FOR EACH ROW

DECLARE
   v_cat NUMBER;

BEGIN

   SELECT idcateg
   INTO v_cat
   FROM Produits
   WHERE idproduit = :NEW.idproduit;

   IF v_cat = 50 AND :NEW.quantite >= 100 THEN

      INSERTLIGNE1@SITE1_LINK(
         :NEW.idlignecommande,
         :NEW.idcommande,
         :NEW.idproduit,
         :NEW.quantite,
         :NEW.remise
      );

   ELSIF v_cat = 35 AND :NEW.quantite < 100 THEN

      INSERTLIGNE2@SITE2_LINK(
         :NEW.idlignecommande,
         :NEW.idcommande,
         :NEW.idproduit,
         :NEW.quantite,
         :NEW.remise
      );

   END IF;

END;
/

-- -- =========================================
-- -- TRIGGER : SYC_INSERT_LIGNE
-- -- =========================================
-- -- Ce trigger répartit automatiquement les INSERT
-- -- vers SITE1 ou SITE2 selon la règle de fragmentation
-- -- =========================================

-- CREATE OR REPLACE TRIGGER SYC_INSERT_LIGNE
-- AFTER INSERT ON LigneCommandes
-- FOR EACH ROW

-- DECLARE
--    v_cat NUMBER;

-- BEGIN

--    -- =========================================
--    -- Récupération de la catégorie produit
--    -- =========================================
--    SELECT idcateg
--    INTO v_cat
--    FROM Produits@SITE_GLOBAL
--    WHERE idproduit = :NEW.idproduit;


--    -- =========================================
--    -- CAS 1 : SITE 1 (gros volumes + catégorie 50)
--    -- =========================================
--    IF v_cat = 50 AND :NEW.quantite > 100 THEN

--       INSERT INTO LigneCommandes1@SITE1
--       VALUES (
--          :NEW.idlignecommande,
--          :NEW.idcommande,
--          :NEW.idproduit,
--          :NEW.quantite,
--          :NEW.remise
--       );


--    -- =========================================
--    -- CAS 2 : SITE 2 (catégorie 35 + quantités <= 100)
--    -- =========================================
--    ELSIF v_cat = 35 AND :NEW.quantite <= 100 THEN

--       INSERT INTO LigneCommandes2@SITE2
--       VALUES (
--          :NEW.idlignecommande,
--          :NEW.idcommande,
--          :NEW.idproduit,
--          :NEW.quantite,
--          :NEW.remise
--       );

--    END IF;

-- END;
-- /


-- CREATE OR REPLACE TRIGGER SYC_INSERT_LIGNE
-- AFTER INSERT ON LigneCommandes
-- FOR EACH ROW
-- DECLARE
--    v_cat NUMBER;
-- BEGIN

--    SELECT idcateg INTO v_cat
--    FROM Produits
--    WHERE idproduit = :NEW.idproduit;

--    IF v_cat = 50 AND :NEW.quantite > 100 THEN

--       INSERT INTO LigneCommandes1
--       VALUES (:NEW.idlignecommande, :NEW.idcommande,
--               :NEW.idproduit, :NEW.quantite, :NEW.remise);

--    ELSIF v_cat = 35 AND :NEW.quantite > 50 THEN

--       INSERT INTO LigneCommandes2@site2
--       VALUES (:NEW.idlignecommande, :NEW.idcommande,
--               :NEW.idproduit, :NEW.quantite, :NEW.remise);

--    END IF;

-- END;
-- /


-- CREATE OR REPLACE TRIGGER SYC_INSERT_LIGNE
-- AFTER INSERT ON LigneCommandes
-- FOR EACH ROW
-- DECLARE
--     v_cat NUMBER;
-- BEGIN

--     SELECT idcateg INTO v_cat
--     FROM Produits
--     WHERE idproduit = :NEW.idproduit;

--     IF v_cat = 50 AND :NEW.quantite > 100 THEN

--         INSERT INTO LigneCommandes1
--         VALUES (:NEW.idlignecommande, :NEW.idcommande,
--                 :NEW.idproduit, :NEW.quantite, :NEW.remise);

--     ELSIF v_cat = 35 AND :NEW.quantite > 50 THEN

--         INSERT INTO SYSTEM.LigneCommandes2@site2
--         VALUES (:NEW.idlignecommande, :NEW.idcommande,
--                 :NEW.idproduit, :NEW.quantite, :NEW.remise);

--     END IF;

-- END;
-- /
-- CREATE OR REPLACE TRIGGER SYC_INSERT_LIGNE
-- -- BEFORE INSERT ON LigneCommandes
-- AFTER INSERT ON LigneCommandes
-- FOR EACH ROW
-- DECLARE
--     v_cat Produits.idcateg%TYPE;
-- BEGIN

--     SELECT idcateg
--     INTO v_cat
--     FROM Produits
--     WHERE idproduit = :NEW.idproduit;

--     -- SITE 1 : gros volume / catégorie 50
--     IF v_cat = 50 AND :NEW.quantite > 100 THEN

--         INSERT INTO LigneCommandes1
--         VALUES (
--             :NEW.idlignecommande,
--             :NEW.idcommande,
--             :NEW.idproduit,
--             :NEW.quantite,
--             :NEW.remise
--         );

--     -- SITE 2 : petits volumes / catégorie 35
--     ELSIF v_cat = 35 AND :NEW.quantite > 50 THEN

--         INSERT INTO LigneCommandes2@site2
--         VALUES (
--             :NEW.idlignecommande,
--             :NEW.idcommande,
--             :NEW.idproduit,
--             :NEW.quantite,
--             :NEW.remise
--         );

--     END IF;

-- END;
-- /

INSERT INTO LigneCommandes1 VALUES (1, 101, 1001, 120, 10);
INSERT INTO LigneCommandes1 VALUES (2, 101, 1002, 150, 5);
INSERT INTO LigneCommandes1 VALUES (3, 300, 1001, 200, 0);

-- INSERT INTO LigneCommandes VALUES (1,101,1001,120,10);

-- SELECT * FROM Produits WHERE idproduit = 1001;
-- SELECT * FROM Produits WHERE idproduit = 1001;
-- INSERT INTO Produits VALUES (1001, 50, 'Produit Test', 200);