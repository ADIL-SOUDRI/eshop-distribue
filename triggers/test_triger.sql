/* =========================================================
   TEST DES TRIGGERS - ESHOP DISTRIBUÉ
   Objectif : tester INSERT / UPDATE / DELETE + distribution
   ========================================================= */

-- =========================================================
-- 1. TEST INSERT TRIGGER (SYC_INSERT_LIGNE)
-- =========================================================
-- Insère une ligne dans la table globale
-- Le trigger doit envoyer automatiquement vers Site1 ou Site2
-- selon la catégorie et la quantité

INSERT INTO LigneCommandes VALUES (1, 10, 1001, 120, 5);
-- Produit 1001 (catégorie 50) => SITE1 (quantite >= 100)

INSERT INTO LigneCommandes VALUES (2, 11, 2001, 50, 2);
-- Produit 2001 (catégorie 35) => SITE2 (quantite < 100)

INSERT INTO LigneCommandes VALUES (3, 12, 3001, 200, 10);
-- Produit 3001 (catégorie 50) => SITE1

COMMIT;

-- Vérification après INSERT
SELECT * FROM LigneCommandes1;
SELECT * FROM LigneCommandes2;


-- =========================================================
-- 2. TEST UPDATE TRIGGER (SYC_UPDATE_LIGNE)
-- =========================================================
-- Mise à jour d'une ligne existante
-- Le trigger doit déplacer / mettre à jour le bon site

UPDATE LigneCommandes
SET idproduit = 1002,
    quantite = 300,
    remise = 10
WHERE idlignecommande = 1;
-- Catégorie 50 => SITE1

UPDATE LigneCommandes
SET idproduit = 2002,
    quantite = 80,
    remise = 5
WHERE idlignecommande = 2;
-- Catégorie 35 => SITE2

COMMIT;

-- Vérification UPDATE
SELECT * FROM LigneCommandes1;
SELECT * FROM LigneCommandes2;


-- =========================================================
-- 3. TEST DELETE TRIGGER (SYC_DELETE_LIGNE)
-- =========================================================
-- Suppression d'une ligne dans la table globale
-- Le trigger doit supprimer dans le bon site

DELETE FROM LigneCommandes
WHERE idlignecommande = 1;

DELETE FROM LigneCommandes
WHERE idlignecommande = 2;

COMMIT;

-- Vérification DELETE
SELECT * FROM LigneCommandes1;
SELECT * FROM LigneCommandes2;


-- =========================================================
-- 4. VERIFICATION GLOBALE FINALE
-- =========================================================

SELECT * FROM LigneCommandes;
SELECT * FROM LigneCommandes1;
SELECT * FROM LigneCommandes2;

-- Les triggers assurent la distribution automatique des données entre Site1 et Site2.

-- - SYC_INSERT_LIGNE : route les insertions selon catégorie et quantité
-- - SYC_UPDATE_LIGNE : met à jour les fragments concernés
-- - SYC_DELETE_LIGNE : supprime les données dans le bon site

-- Cela garantit la transparence de la fragmentation horizontale.
-- =========================================================
-- FIN TEST TRIGGERS
-- =========================================================