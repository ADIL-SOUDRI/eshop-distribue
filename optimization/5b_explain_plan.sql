EXPLAIN PLAN FOR
SELECT c.idclient, COUNT(*)
FROM Clients c
JOIN Commandes co ON c.idclient = co.idclient
JOIN LigneCommandes l ON co.idcommande = l.idcommande
WHERE EXTRACT(YEAR FROM co.datecommande) = 2026
GROUP BY c.idclient;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- Le plan d’exécution peut montrer :

-- 1. FULL TABLE SCAN sur la table Commandes
--    → car filtre EXTRACT(YEAR) empêche l’utilisation directe d’un index sur date

-- 2. HASH JOIN entre Clients et Commandes
--    → utilisé pour joindre de grandes tables

-- 3. SORT GROUP BY
--    → nécessaire pour le calcul COUNT par client

-- Ces opérations sont coûteuses en cas de grand volume de données.