/* =========================================================
   INDEXES - OPTIMISATION BASE ESHOP DISTRIBUEE
========================================================= */

/* =========================================
   1. INDEX SUR LIGNECOMMANDES (produit)
   Rôle : accélère les JOIN avec Produits
========================================= */
CREATE INDEX idx_lc_produit
ON LigneCommandes(idproduit);

/* =========================================
   2. INDEX SUR COMMANDES (client)
   Rôle : accélère JOIN Clients ↔ Commandes
========================================= */
CREATE INDEX idx_lc_client
ON Commandes(idclient);

/* =========================================
   3. INDEX SUR PRODUITS (catégorie)
   Rôle : utilisé pour fragmentation + CA
========================================= */
CREATE INDEX idx_produit_categ
ON Produits(idcateg);

/* =========================================
   4. INDEX SUR COMMANDES (date)
   Rôle : filtrage des commandes 2026
========================================= */
CREATE INDEX idx_commande_date
ON Commandes(datecommande);
/* =========================================
   INDEX COMPOSITE (OPTIMISATION AVANCEE)
   Rôle : accélère les jointures complexes
========================================= */
CREATE INDEX idx_lc_cmd_prod
ON LigneCommandes(idcommande, idproduit);

/* =========================================
   INDEX POUR CALCUL CA
   Rôle : optimisation calcul quantité/remise
========================================= */
CREATE INDEX idx_lc_quantite_remise
ON LigneCommandes(quantite, remise);



/* ========================================
   TEST DE L'INDEX IDX_LC_CLIENT
======================================== */

/* Avant activation de l'index */
ALTER INDEX idx_lc_client INVISIBLE;

EXPLAIN PLAN FOR
SELECT *
FROM Commandes
WHERE idclient = 1;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

/* Après activation de l'index */
ALTER INDEX idx_lc_client VISIBLE;

EXPLAIN PLAN FOR
SELECT 
*
FROM Commandes
WHERE idclient = 1;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

/* Mesure du temps d'exécution */
DECLARE
  v_start NUMBER;
  v_end NUMBER;
  v_count NUMBER;
BEGIN
  v_start := DBMS_UTILITY.GET_TIME();

  SELECT COUNT(*)
  INTO v_count
  FROM Commandes
  WHERE idclient = 1;

  v_end := DBMS_UTILITY.GET_TIME();

  DBMS_OUTPUT.PUT_LINE('Temps : ' ||
                       (v_end-v_start)/100 || ' secondes');
END;
/

-- /* ========================================
--    TEST DE L'INDEX IDX_COMMANDE_DATE
-- ======================================== */

-- /* Avant activation de l'index */
-- ALTER INDEX idx_commande_date INVISIBLE;

-- EXPLAIN PLAN FOR
-- SELECT *
-- FROM Commandes
-- WHERE datecommande BETWEEN DATE '2026-01-01'
--                       AND DATE '2026-12-31';

-- SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- /* Après activation de l'index */
-- ALTER INDEX idx_commande_date VISIBLE;

-- EXPLAIN PLAN FOR
-- SELECT *
-- FROM Commandes
-- WHERE datecommande BETWEEN DATE '2026-01-01'
--                       AND DATE '2026-12-31';

-- SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- /* Mesure du temps d'exécution */
-- DECLARE
--   v_start NUMBER;
--   v_end NUMBER;
--   v_count NUMBER;
-- BEGIN
--   v_start := DBMS_UTILITY.GET_TIME();

--   SELECT COUNT(*)
--   INTO v_count
--   FROM Commandes
--   WHERE datecommande BETWEEN DATE '2026-01-01'
--                         AND DATE '2026-12-31';

--   v_end := DBMS_UTILITY.GET_TIME();

--   DBMS_OUTPUT.PUT_LINE('Temps : ' ||
--                        (v_end-v_start)/100 || ' secondes');
-- END;
-- /

-- /* ========================================
--    TEST DE L'INDEX IDX_LC_PRODUIT
-- ======================================== */

-- /* Avant activation de l'index */
ALTER INDEX idx_lc_produit INVISIBLE;

EXPLAIN PLAN FOR
SELECT 
*
FROM LigneCommandes
WHERE idproduit = 10;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- /* Après activation de l'index */
ALTER INDEX idx_lc_produit VISIBLE;
EXPLAIN PLAN FOR
SELECT /*+ INDEX(LigneCommandes idx_lc_produit) */
*
FROM LigneCommandes
WHERE idproduit = 10;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);


-- /* Mesure du temps d'exécution */
DECLARE
  v_start NUMBER;
  v_end NUMBER;
  v_count NUMBER;
BEGIN
  v_start := DBMS_UTILITY.GET_TIME();

  SELECT COUNT(*)
  INTO v_count
  FROM LigneCommandes
  WHERE idproduit = 10;

  v_end := DBMS_UTILITY.GET_TIME();

  DBMS_OUTPUT.PUT_LINE('Temps : ' ||
                       (v_end-v_start)/100 || ' secondes');
END;
/

/* ========================================
   TEST DE L'INDEX IDX_PRODUIT_CATEG
======================================== */

-- /* Avant activation de l'index */
-- ALTER INDEX idx_produit_categ INVISIBLE;

-- EXPLAIN PLAN FOR
-- SELECT *
-- FROM Produits
-- WHERE idcateg = 50;

-- SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- /* Après activation de l'index */
-- ALTER INDEX idx_produit_categ VISIBLE;

-- EXPLAIN PLAN FOR
-- SELECT *
-- FROM Produits
-- WHERE idcateg = 50;

-- SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- /* Mesure du temps d'exécution */
-- DECLARE
--   v_start NUMBER;
--   v_end NUMBER;
--   v_count NUMBER;
-- BEGIN
--   v_start := DBMS_UTILITY.GET_TIME();

--   SELECT COUNT(*)
--   INTO v_count
--   FROM Produits
--   WHERE idcateg = 50;

--   v_end := DBMS_UTILITY.GET_TIME();

--   DBMS_OUTPUT.PUT_LINE('Temps : ' ||
--                        (v_end-v_start)/100 || ' secondes');
-- END;
-- /


/* ========================================
   TEST DE L'INDEX IDX_LC_CMD_PROD
======================================== */

/* Avant activation de l'index */
ALTER INDEX idx_lc_cmd_prod INVISIBLE;

EXPLAIN PLAN FOR
SELECT /*+ INDEX(LigneCommandes idx_lc_cmd_prod) */
*
FROM LigneCommandes
WHERE idcommande = 1
AND idproduit = 10;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

/* Après activation de l'index */
ALTER INDEX idx_lc_cmd_prod VISIBLE;

EXPLAIN PLAN FOR
SELECT /*+ INDEX(LigneCommandes idx_lc_cmd_prod) */
*
FROM LigneCommandes
WHERE idcommande = 1
AND idproduit = 10;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

/* Mesure du temps d'exécution */
DECLARE
  v_start NUMBER;
  v_end NUMBER;
  v_count NUMBER;
BEGIN
  v_start := DBMS_UTILITY.GET_TIME();

  SELECT COUNT(*)
  INTO v_count
  FROM LigneCommandes
  WHERE idcommande = 1
  AND idproduit = 10;

  v_end := DBMS_UTILITY.GET_TIME();

  DBMS_OUTPUT.PUT_LINE('Temps : ' ||
                       (v_end-v_start)/100 || ' secondes');
END;
/

/* ========================================
   TEST DE L'INDEX IDX_LC_QUANTITE_REMISE
======================================== */

/* Avant activation de l'index */
ALTER INDEX idx_lc_quantite_remise INVISIBLE;

EXPLAIN PLAN FOR
SELECT *
FROM LigneCommandes
WHERE quantite > 50
AND remise > 0;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

/* Après activation de l'index */
ALTER INDEX idx_lc_quantite_remise VISIBLE;

EXPLAIN PLAN FOR
SELECT *
FROM LigneCommandes
WHERE quantite > 50
AND remise > 0;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

/* Mesure du temps d'exécution */
DECLARE
  v_start NUMBER;
  v_end NUMBER;
  v_count NUMBER;
BEGIN
  v_start := DBMS_UTILITY.GET_TIME();

  SELECT COUNT(*)
  INTO v_count
  FROM LigneCommandes
  WHERE quantite > 50
  AND remise > 0;

  v_end := DBMS_UTILITY.GET_TIME();

  DBMS_OUTPUT.PUT_LINE('Temps : ' ||
                       (v_end-v_start)/100 || ' secondes');
END;
/





-- Surveillance des Sessions Oracle
SELECT SID,
       SERIAL#,
       STATUS,
       MACHINE,
       PROGRAM
FROM V$SESSION
WHERE STATUS = 'ACTIVE';


-- Vérification de l'État des Index
SELECT index_name, table_name
FROM user_indexes
WHERE index_name LIKE 'IDX%'
ORDER BY table_name;





--  passez-les en INVISIBLE (plus propre que DROP)

ALTER INDEX idx_lc_quantite_remise  INVISIBLE;
ALTER INDEX idx_commande_date INVISIBLE;
ALTER INDEX idx_produit_categ INVISIBLE;
ALTER INDEX idx_lc_client INVISIBLE;
ALTER INDEX idx_lc_produit INVISIBLE;

ALTER INDEX idx_lc_cmd_prod VISIBLE;
ALTER INDEX idx_lc_quantite_remise  VISIBLE;
ALTER INDEX idx_commande_date VISIBLE;
ALTER INDEX idx_produit_categ VISIBLE;
ALTER INDEX idx_lc_client VISIBLE;
ALTER INDEX idx_lc_produit VISIBLE;


SET AUTOTRACE ON;
SET TIMING ON;
-- Reconstruction des Index (Maintenance)
ALTER INDEX idx_lc_client  REBUILD;
ALTER INDEX idx_lc_cmd_prod  REBUILD;
-- Mise à Jour des Statistiques Oracle
EXEC DBMS_STATS.GATHER_SCHEMA_STATS(USER);
