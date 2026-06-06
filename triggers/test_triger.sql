/* =========================================================
   TEST DES TRIGGERS - ESHOP DISTRIBUÉ
   Objectif : tester INSERT / UPDATE / DELETE + distribution
   ========================================================= */
-- desativer tous les triggers d'abord

ALTER TRIGGER  SYC_INSERT_LIGNE DISABLE;
ALTER TRIGGER SYC_UPDATE_LIGNE DISABLE;
ALTER TRIGGER SYC_DELETE_LIGNE DISABLE;
-- Activer tous les triggers d'abord

ALTER TRIGGER SYC_INSERT_LIGNE ENABLE;
ALTER TRIGGER SYC_UPDATE_LIGNE ENABLE;
ALTER TRIGGER SYC_DELETE_LIGNE ENABLE;
-- =========================
-- 1. AFFICHAGE DES TABLES
-- =========================


SELECT * FROM Clients;
SELECT * FROM Produits;
SELECT * FROM Commandes;
SELECT * FROM LigneCommandes;
-- =========================
-- 2. INSERTION CLIENTS
-- =========================

BEGIN

    INSERT INTO Clients VALUES (1, 'CLI001', 'Société Atlas');
    INSERT INTO Clients VALUES (2, 'CLI002', 'Société Omega');
    INSERT INTO Clients VALUES (3, 'CLI003', 'Société Nova');
    INSERT INTO Clients VALUES (4, 'CLI004', 'Société Delta');

    DBMS_OUTPUT.PUT_LINE('Clients insérés avec succès.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erreur Clients : ' || SQLERRM);

END;
/
COMMIT;


-- =========================
-- 3. INSERTION PRODUITS
-- =========================

BEGIN

    INSERT INTO Produits VALUES (1001, 50, 'Serveur Dell PowerEdge', 20000);
    INSERT INTO Produits VALUES (1002, 50, 'PC HP Workstation', 12000);
    INSERT INTO Produits VALUES (2001, 35, 'Clavier Logitech', 300);
    INSERT INTO Produits VALUES (2002, 35, 'Souris Gaming', 150);
    INSERT INTO Produits VALUES (2003, 35, 'Écran Samsung 24"', 1800);

    INSERT INTO Produits VALUES (3001, 50, 'Serveur IBM XSeries', 30000);
    INSERT INTO Produits VALUES (3002, 50, 'Laptop Lenovo ThinkPad', 15000);
    INSERT INTO Produits VALUES (4001, 35, 'Casque Audio Sony', 600);
    INSERT INTO Produits VALUES (4002, 35, 'Webcam HD Logitech', 450);
    INSERT INTO Produits VALUES (4003, 35, 'Imprimante Epson', 2200);

    DBMS_OUTPUT.PUT_LINE('Produits insérés avec succès.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erreur Produits : ' || SQLERRM);

END;
/
COMMIT;
-- =========================
-- 4. INSERTION COMMANDES
-- =========================

BEGIN

    INSERT INTO Commandes VALUES (1, 1, TO_DATE('2026-01-10','YYYY-MM-DD'));
    INSERT INTO Commandes VALUES (2, 2, TO_DATE('2026-02-15','YYYY-MM-DD'));
    INSERT INTO Commandes VALUES (3, 3, TO_DATE('2026-03-20','YYYY-MM-DD'));
    INSERT INTO Commandes VALUES (4, 4, TO_DATE('2026-04-05','YYYY-MM-DD'));

    INSERT INTO Commandes VALUES (5, 1, TO_DATE('2026-05-01','YYYY-MM-DD'));
    INSERT INTO Commandes VALUES (6, 2, TO_DATE('2026-05-10','YYYY-MM-DD'));
    INSERT INTO Commandes VALUES (7, 3, TO_DATE('2026-06-15','YYYY-MM-DD'));
    INSERT INTO Commandes VALUES (8, 4, TO_DATE('2026-07-20','YYYY-MM-DD'));

    DBMS_OUTPUT.PUT_LINE('Commandes insérées avec succès.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erreur Commandes : ' || SQLERRM);

END;
/
COMMIT;


-- =========================
-- 5. INSERTION LIGNE COMMANDES
-- =========================

BEGIN

    INSERT INTO LigneCommandes VALUES (1, 1, 1001, 120, 5);
    INSERT INTO LigneCommandes VALUES (2, 2, 1002, 150, 10);
    INSERT INTO LigneCommandes VALUES (3, 3, 2001, 20, 0);
    INSERT INTO LigneCommandes VALUES (4, 4, 2002, 50, 2);
    INSERT INTO LigneCommandes VALUES (5, 1, 2003, 30, 3);

    INSERT INTO LigneCommandes VALUES (6, 5, 3001, 200, 10);
    INSERT INTO LigneCommandes VALUES (7, 6, 3002, 120, 5);
    INSERT INTO LigneCommandes VALUES (8, 7, 4001, 25, 0);
    INSERT INTO LigneCommandes VALUES (9, 8, 4002, 40, 3);
    INSERT INTO LigneCommandes VALUES (10, 9, 4003, 60, 2);

    INSERT INTO LigneCommandes VALUES (11, 1, 1001, 150, 2);
    INSERT INTO LigneCommandes VALUES (12, 2, 1002, 100, 5);
    INSERT INTO LigneCommandes VALUES (13, 3, 3001, 150, 8);
    INSERT INTO LigneCommandes VALUES (14, 4, 3002, 154, 3);
    INSERT INTO LigneCommandes VALUES (15, 1, 3001, 145, 4);

    INSERT INTO LigneCommandes VALUES (16, 5, 2001, 60, 1);
    INSERT INTO LigneCommandes VALUES (17, 6, 2002, 70, 0);
    INSERT INTO LigneCommandes VALUES (18, 7, 2003, 80, 2);
    INSERT INTO LigneCommandes VALUES (19, 8, 4001, 90, 1);
    INSERT INTO LigneCommandes VALUES (20, 9, 4002, 85, 0);

    INSERT INTO LigneCommandes VALUES (21, 1, 3001, 121, 5);
    INSERT INTO LigneCommandes VALUES (22, 12, 2001, 40, 2);
    INSERT INTO LigneCommandes VALUES (23, 12, 2001, 90, 2);
    INSERT INTO LigneCommandes VALUES (24, 3, 1001, 120, 0);
    INSERT INTO LigneCommandes VALUES (25, 1, 1001, 120, 5);
    INSERT INTO LigneCommandes VALUES (26, 1, 1001, 120, 5);

    DBMS_OUTPUT.PUT_LINE('Lignes de commandes insérées avec succès.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erreur LigneCommandes : ' || SQLERRM);

END;
/
COMMIT;

-- =========================
-- 6. UPDATE LIGNE COMMANDES
-- =========================

BEGIN

    UPDATE LigneCommandes
    SET quantite = 200,
        remise = 15
    WHERE idlignecommande = 1;

    UPDATE LigneCommandes
    -- SET idproduit = 1001,
    SET
        quantite = 30,
        remise = 5
    WHERE idlignecommande = 3;

    DBMS_OUTPUT.PUT_LINE('Mise à jour effectuée.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erreur UPDATE : ' || SQLERRM);

END;
/
COMMIT;

-- =========================
-- 7. DELETE DONNEES
-- =========================

-- 8.1 SUPPRESSION DE DONNÉES SPÉCIFIQUES
BEGIN

    DELETE FROM LigneCommandes
    WHERE idlignecommande = 26;

    DELETE FROM LigneCommandes
    WHERE idlignecommande = 23;

    DBMS_OUTPUT.PUT_LINE('Suppressions effectuées.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erreur DELETE : ' || SQLERRM);

END;
/
COMMIT;
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

--  créer une vue globale
CREATE OR REPLACE VIEW V_GLOBAL_LIGNES AS
SELECT * FROM LigneCommandes1@SITE1_LINK
UNION ALL
SELECT * FROM LigneCommandes2@SITE2_LINK;
-- — tester
SELECT * FROM V_GLOBAL_LIGNES 
ORDER BY IDLIGNECOMMANDE ASC;



-- -- =========================================================
-- -- 1. TEST INSERT TRIGGER (SYC_INSERT_LIGNE)
-- -- =========================================================
-- -- Insère une ligne dans la table globale
-- -- Le trigger doit envoyer automatiquement vers Site1 ou Site2
-- -- selon la catégorie et la quantité
-- CREATE TABLE LigneCommandes (
--     idlignecommande NUMBER PRIMARY KEY,
--     idcommande NUMBER,
--     idproduit NUMBER,
--     quantite NUMBER,
--     remise NUMBER
-- );

-- INSERT INTO LigneCommandes VALUES (1, 1, 1001, 120, 5);
-- -- Produit 1001 (catégorie 50) => SITE1 (quantite >= 100)

-- INSERT INTO LigneCommandes VALUES (22, 2, 2001, 50, 2);
-- -- Produit 2001 (catégorie 35) => SITE2 (quantite < 100)

-- INSERT INTO LigneCommandes VALUES (23, 3, 3001, 200, 10);
-- -- Produit 3001 (catégorie 50) => SITE1


-- INSERT INTO LigneCommandes VALUES (24, 1, 1001, 150, 2);
-- INSERT INTO LigneCommandes VALUES (25, 2, 1002, 100, 5);
-- INSERT INTO LigneCommandes VALUES (26, 3, 3001, 150, 8);
-- INSERT INTO LigneCommandes VALUES (27, 4, 3002, 154, 3);
-- INSERT INTO LigneCommandes VALUES (28, 1, 3001, 145, 4);

-- INSERT INTO LigneCommandes VALUES (29, 5, 2001, 60, 1);
-- INSERT INTO LigneCommandes VALUES (30, 6, 2002, 70, 0);
-- INSERT INTO LigneCommandes VALUES (31, 7, 2003, 80, 2);
-- INSERT INTO LigneCommandes VALUES (32, 8, 4001, 90, 1);
-- INSERT INTO LigneCommandes VALUES (33, 5, 4002, 85, 0);

-- COMMIT;

-- -- Vérification après INSERT
-- SELECT * FROM LigneCommandes1;
-- SELECT * FROM LigneCommandes2;


-- -- =========================================================
-- -- 2. TEST UPDATE TRIGGER (SYC_UPDATE_LIGNE)
-- -- =========================================================
-- -- Mise à jour d'une ligne existante
-- -- Le trigger doit déplacer / mettre à jour le bon site

-- UPDATE LigneCommandes
-- SET idproduit = 1002,
--     quantite = 300,
--     remise = 10
-- WHERE idlignecommande = 1;
-- -- Catégorie 50 => SITE1

-- UPDATE LigneCommandes
-- SET idproduit = 2002,
--     quantite = 80,
--     remise = 5
-- WHERE idlignecommande = 2;
-- -- Catégorie 35 => SITE2

-- COMMIT;

-- -- Vérification UPDATE
-- SELECT * FROM LigneCommandes1;
-- SELECT * FROM LigneCommandes2;


-- -- =========================================================
-- -- 3. TEST DELETE TRIGGER (SYC_DELETE_LIGNE)
-- -- =========================================================
-- -- Suppression d'une ligne dans la table globale
-- -- Le trigger doit supprimer dans le bon site

-- DELETE FROM LigneCommandes
-- WHERE idlignecommande = 1;

-- DELETE FROM LigneCommandes
-- WHERE idlignecommande = 2;

-- COMMIT;

-- -- Vérification DELETE
-- SELECT * FROM LigneCommandes1;
-- SELECT * FROM LigneCommandes2;


-- -- =========================================================
-- -- 4. VERIFICATION GLOBALE FINALE
-- -- =========================================================

-- SELECT * FROM LigneCommandes;
-- SELECT * FROM LigneCommandes1;
-- SELECT * FROM LigneCommandes2;

-- Les triggers assurent la distribution automatique des données entre Site1 et Site2.

-- - SYC_INSERT_LIGNE : route les insertions selon catégorie et quantité
-- - SYC_UPDATE_LIGNE : met à jour les fragments concernés
-- - SYC_DELETE_LIGNE : supprime les données dans le bon site

-- Cela garantit la transparence de la fragmentation horizontale.
-- =========================================================
-- FIN TEST TRIGGERS
-- =========================================================