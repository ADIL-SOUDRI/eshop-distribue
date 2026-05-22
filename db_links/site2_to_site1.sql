

-- =========================================
-- Suppression du DATABASE LINK site1 s’il existe déjà
-- (évite l’erreur ORA-02024 : database link does not exist)
-- =========================================
BEGIN
   EXECUTE IMMEDIATE 'DROP DATABASE LINK site1';
EXCEPTION
   WHEN OTHERS THEN NULL;  -- ignore l’erreur si le lien n’existe pas
END;
/
DROP DATABASE LINK site2;
-- =========================================
-- Création du DATABASE LINK vers SITE1
-- =========================================
-- Ce lien permet de se connecter à la base distante SITE1
-- via le container Docker oracle_site1
CREATE DATABASE LINK site1
CONNECT TO system IDENTIFIED BY oracle
USING '(DESCRIPTION=
  (ADDRESS=(PROTOCOL=TCP)(HOST=oracle_site1)(PORT=1521))
  (CONNECT_DATA=(SERVICE_NAME=xepdb1))
)';

CREATE DATABASE LINK site2
CONNECT TO system IDENTIFIED BY oracle
USING '(DESCRIPTION=
  (ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1529))
  (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
)';

-- =========================================
-- Test simple du DATABASE LINK (doit retourner X)
-- =========================================
SELECT * FROM dual@site1;

-- =========================================
-- Test de connexion minimale (doit retourner 1)
-- =========================================
SELECT 1 FROM dual@site1;

-- =========================================
-- Accès aux données distantes SITE1
-- =========================================
SELECT * FROM Clients1@site1;

-- Lecture de la table Produits1 distante
SELECT * FROM Produits1@site1;

-- Lecture de la table Commandes1 distante
SELECT * FROM Commandes1@site1;
-- 1
-- BEGIN
--    EXECUTE IMMEDIATE 'DROP DATABASE LINK site1';
-- EXCEPTION
--    WHEN OTHERS THEN NULL;
-- END;
-- /
-- CREATE DATABASE LINK site1
-- CONNECT TO system IDENTIFIED BY oracle
-- USING '(DESCRIPTION=
--   (ADDRESS=(PROTOCOL=TCP)(HOST=oracle_site1)(PORT=1521))
--   (CONNECT_DATA=(SERVICE_NAME=xepdb1))
-- )';
-- SELECT * FROM dual@site1;
-- SELECT 1 FROM dual@site1;
-- SELECT * FROM Clients1@site1;
-- SELECT * FROM Produits1@site1;
-- SELECT * FROM Commandes1@site1;

-- DROP DATABASE LINK site1;

-- CREATE DATABASE LINK site1
-- CONNECT TO system IDENTIFIED BY oracle
-- USING '
-- (DESCRIPTION=
--  (ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521))
--  (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
-- )';

-- SELECT * FROM dual@site1;

-- SELECT * FROM Clients1@site1;

