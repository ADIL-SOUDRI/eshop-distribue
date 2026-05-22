INSERT INTO LigneCommandes
VALUES (1,101,1001,120,10);

SELECT 'Global' AS site, idlignecommande, quantite, remise FROM LigneCommandes
UNION ALL
SELECT 'Site1', idlignecommande, quantite, remise FROM LigneCommandes1
UNION ALL
SELECT 'Site2', idlignecommande, quantite, remise FROM LigneCommandes2@site2
ORDER BY site, idlignecommande;