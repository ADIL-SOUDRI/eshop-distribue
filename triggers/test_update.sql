ROLLBACK;

UPDATE LigneCommandes
SET quantite = 200
WHERE idlignecommande = 1001;

COMMIT;