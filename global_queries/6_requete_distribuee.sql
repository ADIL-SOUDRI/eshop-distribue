-- =========================================
-- CHIFFRE D'AFFAIRES PAR CATEGORIE (2026)
-- DISTRIBUE SITE1 + SITE2
-- =========================================
SELECT idcateg,
       SUM(ca_total) AS ca_total
FROM (
    SELECT p.idcateg,
           SUM(l.quantite * p.prixunitaire * (1 - l.remise/100)) AS ca_total
    FROM LigneCommandes1@SITE1_LINK l
    JOIN Produits1@SITE1_LINK p ON l.idproduit = p.idproduit
    JOIN Commandes1@SITE1_LINK c ON l.idcommande = c.idcommande
    WHERE EXTRACT(YEAR FROM c.datecommande) = 2026
    GROUP BY p.idcateg

    UNION ALL

    SELECT p.idcateg,
           SUM(l.quantite * p.prixunitaire * (1 - l.remise/100)) AS ca_total
    FROM LigneCommandes2@SITE2_LINK l
    JOIN Produits2@SITE2_LINK p ON l.idproduit = p.idproduit
    JOIN Commandes2@SITE2_LINK c ON l.idcommande = c.idcommande
    WHERE EXTRACT(YEAR FROM c.datecommande) = 2026
    GROUP BY p.idcateg
)
GROUP BY idcateg;