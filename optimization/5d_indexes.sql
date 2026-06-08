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





SELECT index_name, table_name
FROM user_indexes
ORDER BY table_name;

DROP INDEX idx_produit_categ;

SELECT *
FROM Produits
WHERE idcateg = 50;

EXPLAIN PLAN FOR
SELECT *
FROM Produits
WHERE idcateg = 50;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

DROP INDEX idx_produit_categ;
EXPLAIN PLAN FOR
SELECT *
FROM Produits
WHERE idcateg = 50;
SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

EXPLAIN PLAN FOR
SELECT c.idcommande,
       lc.idproduit
FROM Commandes c
JOIN LigneCommandes lc
ON c.idcommande = lc.idcommande;
SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);
SELECT index_name,
       table_name,
       status
FROM user_indexes;

SELECT index_name
FROM user_indexes
WHERE table_name='PRODUITS';
SELECT COUNT(*)
FROM Produits;