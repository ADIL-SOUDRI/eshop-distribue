-- Suppression du database link site2 s’il existe déjà
DROP DATABASE LINK site2;
DROP DATABASE LINK site1;



-- Création d’un database link vers SITE2
-- Connexion à la base distante via TCP (Docker / IP + port)
-- CREATE DATABASE LINK site2
-- CONNECT TO system IDENTIFIED BY oracle
-- USING '(DESCRIPTION=
--   (ADDRESS=(PROTOCOL=TCP)(HOST=172.18.0.3)(PORT=1523))
--   (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
-- )';

CREATE DATABASE LINK site2
CONNECT TO system IDENTIFIED BY oracle
USING '(DESCRIPTION=
  (ADDRESS=(PROTOCOL=TCP)(HOST=eshop_site2_db)(PORT=1521))
  (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
)';



-- Test 1 : accès à la table Produits2 via le database link
-- ⚠️ ici le lien utilisé est site2_link (attention au nom)
SELECT * FROM Produits2@site2_link;


-- Test simple du database link via table système DUAL
SELECT * FROM dual@site2;


-- Test 2 : accès à la table Clients2 via SITE2
SELECT * FROM Clients2@site2;


-- Nouveau test du database link SITE2 avec DUAL
SELECT * FROM dual@site2;


-- Test minimal (retourne toujours 1) pour vérifier la connexion
SELECT 1 FROM dual@site2;


-- Vérification des database links existants dans ton schéma
SELECT db_link, username, host
FROM user_db_links;

-- 1
-- DROP DATABASE LINK site2;

-- CREATE DATABASE LINK site2
-- CONNECT TO system IDENTIFIED BY oracle
-- USING '(DESCRIPTION=
--   (ADDRESS=(PROTOCOL=TCP)(HOST=172.18.0.3)(PORT=1521))
--   (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
-- )';
-- SELECT * FROM Produits2@site2_link;
-- SELECT * FROM dual@site2;

-- SELECT * FROM Clients2@site2;
-- SELECT * FROM dual@site2;
-- SELECT 1 FROM dual@site2;

-- SELECT db_link, username, host
-- FROM user_db_links;

-- DROP DATABASE LINK site2;
-- CREATE DATABASE LINK site2
-- CONNECT TO system IDENTIFIED BY oracle
-- USING '(DESCRIPTION=
--   (ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1522))
--   (CONNECT_DATA=(SERVICE_NAME=xepdb1))
-- )';

-- SELECT * FROM dual@site2;








-- CREATE DATABASE LINK site2
-- CONNECT TO system IDENTIFIED BY oracle
-- USING '
-- (DESCRIPTION=
--   (ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1522))
--   (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
-- )';

-- DROP DATABASE LINK site2;

-- SELECT * FROM dual@site2;

-- CREATE DATABASE LINK site2
-- CONNECT TO system IDENTIFIED BY oracle
-- USING '
-- (DESCRIPTION=
--  (ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1522))
--  (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
-- )';


-- CREATE DATABASE LINK site2
-- CONNECT TO system IDENTIFIED BY oracle
-- USING '//localhost:1522/XEPDB1';
-- SELECT * FROM dual@site2;