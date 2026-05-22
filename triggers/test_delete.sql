ROLLBACK;
DELETE FROM LigneCommandes
WHERE idlignecommande = 1001;
COMMIT;