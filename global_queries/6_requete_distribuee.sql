-- =========================================
-- CHIFFRE D'AFFAIRES PAR CATEGORIE (2026)
-- DISTRIBUE SITE1 + SITE2
-- =========================================

SELECT p.idcateg,
       SUM(l.quantite * p.prixunitaire * (1 - l.remise/100)) AS ca_total
FROM LigneCommandes l
JOIN Produits p ON l.idproduit = p.idproduit
JOIN Commandes c ON l.idcommande = c.idcommande
WHERE EXTRACT(YEAR FROM c.datecommande) = 2026
GROUP BY p.idcateg

UNION ALL

SELECT p.idcateg,
       SUM(l.quantite * p.prixunitaire * (1 - l.remise/100)) AS ca_total
FROM LigneCommandes1@site1_link l
JOIN Produits1@site1_link p ON l.idproduit = p.idproduit
JOIN Commandes1@site1_link c ON l.idcommande = c.idcommande
WHERE EXTRACT(YEAR FROM c.datecommande) = 2026
GROUP BY p.idcateg

UNION ALL

SELECT p.idcateg,
       SUM(l.quantite * p.prixunitaire * (1 - l.remise/100)) AS ca_total
FROM LigneCommandes2@site2_link l
JOIN Produits2@site2_link p ON l.idproduit = p.idproduit
JOIN Commandes2@site2_link c ON l.idcommande = c.idcommande
WHERE EXTRACT(YEAR FROM c.datecommande) = 2026
GROUP BY p.idcateg;