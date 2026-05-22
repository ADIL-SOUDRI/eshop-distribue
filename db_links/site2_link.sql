/* =========================================
   DATABASE LINK : SITE1
   ========================================= */

CREATE DATABASE LINK SITE1_LINK
CONNECT TO system IDENTIFIED BY oracle
USING '(DESCRIPTION=
  (ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521))
  (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
)';
-- -- Création d’un database link vers SITE2 (connexion distante)
-- CREATE DATABASE LINK site2
-- CONNECT TO system IDENTIFIED BY oracle
-- USING 'XE';

-- CREATE DATABASE LINK site_global
-- CONNECT TO system IDENTIFIED BY oracle
-- USING '(DESCRIPTION=
--   (ADDRESS=(PROTOCOL=TCP)(HOST=eshop_global_db)(PORT=1521))
--   (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
-- )';
-- CREATE DATABASE LINK SITE2_LINK
-- CONNECT TO system IDENTIFIED BY oracle
-- USING '(DESCRIPTION=
--   (ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1529))
--   (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
-- )';

-- SELECT * FROM dual@SITE2_LINK;
-- SELECT db_link FROM user_db_links;
-- SELECT sysdate FROM dual@site_global;
-- -- Test du database link SITE2 en exécutant une requête sur la table système DUAL distante
-- SELECT * FROM dual@site2;
-- -- 2
-- DROP DATABASE LINK SITE2_LINK;

-- CREATE DATABASE LINK SITE2_LINK
-- CONNECT TO system IDENTIFIED BY oracle
-- USING '(DESCRIPTION=
--   (ADDRESS=(PROTOCOL=TCP)(HOST=eshop_site2_db)(PORT=1521))
--   (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
-- )';
-- -- CREATE DATABASE LINK site2
-- -- CONNECT TO system IDENTIFIED BY oracle
-- -- USING 'XE';
-- -- SELECT * FROM dual@site2;