-- Modifier quantite et remise pour une ligne de Site1
UPDATE LigneCommandes
SET quantite = 200, remise = 10
WHERE idlignecommande = 1001;

COMMIT;