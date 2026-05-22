/* =========================================================
   INDEXES - OPTIMISATION BASE ESHOP DISTRIBUEE
   Objectif :
   - Accélérer les jointures
   - Optimiser les filtres WHERE
   - Améliorer les requêtes analytiques (2026)
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

/* =========================================
   INDEX CLIENT CODE
   Rôle : recherche rapide client
========================================= */
CREATE INDEX idx_client_code
ON Clients(codeclient);