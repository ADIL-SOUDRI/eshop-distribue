
-- =========================
-- TEST GLOBAL DATABASE
-- =========================

SELECT * FROM Clients;
SELECT * FROM Produits;
SELECT * FROM Commandes;
SELECT * FROM LigneCommandes;

INSERT INTO Clients VALUES (1, 'CLI001', 'Société Atlas');
INSERT INTO Clients VALUES (2, 'CLI002', 'Société Omega');
INSERT INTO Clients VALUES (3, 'CLI003', 'Société Nova');
INSERT INTO Clients VALUES (4, 'CLI004', 'Société Delta');

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


INSERT INTO Commandes VALUES (10, 1, TO_DATE('2026-01-10','YYYY-MM-DD'));
INSERT INTO Commandes VALUES (11, 2, TO_DATE('2026-02-15','YYYY-MM-DD'));
INSERT INTO Commandes VALUES (12, 3, TO_DATE('2026-03-20','YYYY-MM-DD'));
INSERT INTO Commandes VALUES (13, 4, TO_DATE('2026-04-05','YYYY-MM-DD'));

INSERT INTO Commandes VALUES (20, 1, TO_DATE('2026-05-01','YYYY-MM-DD'));
INSERT INTO Commandes VALUES (21, 2, TO_DATE('2026-05-10','YYYY-MM-DD'));
INSERT INTO Commandes VALUES (22, 3, TO_DATE('2026-06-15','YYYY-MM-DD'));
INSERT INTO Commandes VALUES (23, 4, TO_DATE('2026-07-20','YYYY-MM-DD'));


INSERT INTO LigneCommandes VALUES (1, 10, 1001, 120, 5);
INSERT INTO LigneCommandes VALUES (2, 11, 1002, 150, 10);
INSERT INTO LigneCommandes VALUES (3, 12, 2001, 20, 0);
INSERT INTO LigneCommandes VALUES (4, 13, 2002, 50, 2);
INSERT INTO LigneCommandes VALUES (5, 10, 2003, 30, 3);

INSERT INTO LigneCommandes VALUES (6, 20, 3001, 200, 10);
INSERT INTO LigneCommandes VALUES (7, 21, 3002, 120, 5);
INSERT INTO LigneCommandes VALUES (8, 22, 4001, 25, 0);
INSERT INTO LigneCommandes VALUES (9, 23, 4002, 40, 3);
INSERT INTO LigneCommandes VALUES (10, 21, 4003, 60, 2);

INSERT INTO LigneCommandes VALUES (11, 10, 1001, 150, 2);
INSERT INTO LigneCommandes VALUES (12, 11, 1002, 100, 5);
INSERT INTO LigneCommandes VALUES (13, 12, 3001, 150, 8);
INSERT INTO LigneCommandes VALUES (14, 13, 3002, 154, 3);
INSERT INTO LigneCommandes VALUES (15, 10, 3001, 145, 4);

INSERT INTO LigneCommandes VALUES (16, 20, 2001, 60, 1);
INSERT INTO LigneCommandes VALUES (17, 21, 2002, 70, 0);
INSERT INTO LigneCommandes VALUES (18, 22, 2003, 80, 2);
INSERT INTO LigneCommandes VALUES (19, 23, 4001, 90, 1);
INSERT INTO LigneCommandes VALUES (20, 20, 4002, 85, 0);

SELECT * FROM LigneCommandes1@SITE1_LINK;
SELECT * FROM LigneCommandes2@SITE2_LINK;

UPDATE LigneCommandes
SET quantite = 200,
    remise = 15
WHERE idlignecommande = 1;

UPDATE LigneCommandes
SET idproduit = 1001,
    quantite = 300,
    remise = 5
WHERE idlignecommande = 2;

DELETE FROM LigneCommandes
WHERE idlignecommande = 2;

DELETE FROM LigneCommandes
WHERE idlignecommande = 5;

commit;

-- BEGIN
--    INSERTLIGNE1@SITE1_LINK(1,1,1,1,1);
-- END;
-- /
-- SELECT * FROM dual@SITE1_LINK;
-- SELECT * FROM dual@SITE2_LINK;
-- DROP DATABASE LINK SITE2_LINK;
-- CREATE DATABASE LINK SITE1_LINK
-- CONNECT TO system IDENTIFIED BY oracle
-- USING '(DESCRIPTION=
--   (ADDRESS=(PROTOCOL=TCP)(HOST=eshop_site1_db)(PORT=1521))
--   (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
-- )';
-- CREATE DATABASE LINK SITE2_LINK
-- CONNECT TO system IDENTIFIED BY oracle
-- USING '(DESCRIPTION=
--   (ADDRESS=(PROTOCOL=TCP)(HOST=eshop_site2_db)(PORT=1521))
--   (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
-- )';