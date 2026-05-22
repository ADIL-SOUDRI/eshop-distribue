SELECT idclient, COUNT(*) AS nb_commandes
FROM Commandes
WHERE EXTRACT(YEAR FROM datecommande) = 2026
GROUP BY idclient;

SELECT 
    c.idclient,
    c.codeclient,
    COUNT(cmd.idcommande) AS nb_commandes
FROM Clients c
JOIN Commandes cmd 
    ON c.idclient = cmd.idclient
WHERE EXTRACT(YEAR FROM cmd.datecommande) = 2026
GROUP BY c.idclient, c.codeclient;

-- -- =========================================
-- -- Nombre de commandes par client en 2026
-- -- =========================================

SELECT c.idclient,
       c.codeclient,
       COUNT(cmd.idcommande) AS nb_commandes
FROM Clients c
JOIN Commandes cmd ON c.idclient = cmd.idclient
WHERE EXTRACT(YEAR FROM cmd.datecommande) = 2026
GROUP BY c.idclient, c.codeclient;

SELECT * FROM LigneCommandes1@SITE1_LINK;
SELECT * FROM LigneCommandes1@SITE1_LINK;