-- desativer tous les triggers SN1

ALTER TRIGGER  SYC_INSERT_LIGNE DISABLE;
ALTER TRIGGER SYC_UPDATE_LIGNE DISABLE;
ALTER TRIGGER SYC_DELETE_LIGNE DISABLE;

-- Activer tous les triggers 

ALTER TRIGGER SYC_INSERT_LIGNE_SC2 ENABLE;
ALTER TRIGGER SYC_UPDATE_LIGNE_SC2 ENABLE;
ALTER TRIGGER SYC_DELETE_LIGNE_SC2 ENABLE;

-- Nettoyage avant test
DELETE FROM LigneCommandes;
DELETE FROM Commandes;
DELETE FROM Clients;
DELETE FROM Produits;
COMMIT;

-- Insertion des données de base
INSERT INTO Clients VALUES (1, 'CLI001', 'Société Atlas');
INSERT INTO Produits VALUES (1001, 50, 'Serveur Dell PowerEdge', 20000);
INSERT INTO Produits VALUES (1002, 35, 'PC Portable Lenovo', 5000);
INSERT INTO Produits VALUES (1003, 50, 'Station Travail HP', 15000);

INSERT INTO Commandes VALUES (10, 1, TO_DATE('2026-01-10', 'YYYY-MM-DD'));
INSERT INTO Commandes VALUES (11, 1, TO_DATE('2026-02-15', 'YYYY-MM-DD'));

-- Insertion des lignes de commande
INSERT INTO LigneCommandes VALUES (1, 10, 1001, 120, 5);  
INSERT INTO LigneCommandes VALUES (2, 10, 1002, 20, 5);   
INSERT INTO LigneCommandes VALUES (3, 11, 1001, 150, 10); 
INSERT INTO LigneCommandes VALUES (4, 11, 1003, 80, 0);   

COMMIT;
-- Affichage des tables de base
SELECT * FROM Clients;
SELECT * FROM Produits;
SELECT * FROM Commandes;
SELECT * FROM LigneCommandes ORDER BY IDLIGNECOMMANDE ASC;

-- Test de mise à jour 1 : Augmentation de la quantité sur la ligne 1
UPDATE LigneCommandes
SET quantite = 150
WHERE idlignecommande = 1;

COMMIT;

-- Test de mise à jour 2 : Augmentation de la quantité sur la ligne 2
UPDATE LigneCommandes
SET 
quantite = 10
WHERE idlignecommande = 2;

COMMIT;

-- Nettoyage des lignes insérées pour le test
DELETE FROM LigneCommandes
WHERE idlignecommande = 1;

DELETE FROM LigneCommandes
WHERE idlignecommande = 2;

COMMIT;

--  créer une vue globale
CREATE OR REPLACE VIEW V_GLOBAL_LIGNES_SC2 AS
SELECT * FROM LigneCommandes1@SITE1_LINK
UNION ALL
SELECT * FROM LigneCommandes2@SITE2_LINK;
-- — tester
SELECT * FROM V_GLOBAL_LIGNES_SC2 
ORDER BY IDLIGNECOMMANDE ASC;
-- desativer tous les triggers 

ALTER TRIGGER  SYC_INSERT_LIGNE_SC2 DISABLE;
ALTER TRIGGER SYC_UPDATE_LIGNE_SC2 DISABLE;
ALTER TRIGGER SYC_DELETE_LIGNE_SC2 DISABLE;
-- Activer tous les triggers 

ALTER TRIGGER SYC_INSERT_LIGNE_SC2 ENABLE;
ALTER TRIGGER SYC_UPDATE_LIGNE_SC2 ENABLE;
ALTER TRIGGER SYC_DELETE_LIGNE_SC2 ENABLE;

-- 8.2 SUPPRESSION DE TOUTES LES DONNÉES 
BEGIN

    DELETE FROM LigneCommandes;
    DELETE FROM Commandes;
    DELETE FROM Produits;
    DELETE FROM Clients;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE(
        'Toutes les données ont été supprimées.'
    );

EXCEPTION
    WHEN OTHERS THEN

        ROLLBACK;

        DBMS_OUTPUT.PUT_LINE(
            'Erreur : ' || SQLERRM
        );

END;
/
COMMit;

-- INSERT INTO LigneCommandes VALUES (1, 10, 1001, 120, 5);
-- INSERT INTO LigneCommandes VALUES (2, 10, 1001, 20, 5);
-- INSERT INTO Commandes VALUES (10, 1, TO_DATE('2026-01-10','YYYY-MM-DD'));
-- INSERT INTO Clients VALUES (1, 'CLI001', 'Société Atlas');
-- INSERT INTO Produits VALUES (1001, 50, 'Serveur Dell PowerEdge', 20000);

-- Commit;

-- delete  from LigneCommandes;