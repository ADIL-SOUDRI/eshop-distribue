
/* =========================================
   DATABASE LINK : SITE2
   ========================================= */

CREATE DATABASE LINK SITE2_LINK
CONNECT TO system IDENTIFIED BY oracle
USING '(DESCRIPTION=
  (ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521))
  (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
)';

SELECT * FROM dual@SITE1_LINK;

-- -- =========================================
-- -- Création du DATABASE LINK vers SITE1
-- -- =========================================
-- CREATE DATABASE LINK site1
-- CONNECT TO system IDENTIFIED BY oracle
-- USING 'XE';

-- CREATE DATABASE LINK site_global
-- CONNECT TO system IDENTIFIED BY oracle
-- USING '(DESCRIPTION=
--   (ADDRESS=(PROTOCOL=TCP)(HOST=eshop_global_db)(PORT=1521))
--   (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
-- )';
-- SELECT db_link FROM user_db_links;
-- SELECT sysdate FROM dual@site_global;
-- -- =========================================
-- -- Suppression sécurisée du DATABASE LINK SITE2
-- -- (évite erreur si le lien n'existe pas)
-- -- =========================================
-- BEGIN
--    EXECUTE IMMEDIATE 'DROP DATABASE LINK site_global';
-- EXCEPTION
--    WHEN OTHERS THEN NULL;
-- END;
-- /

-- -- =========================================
-- -- Vérifier les DATABASE LINKS existants
-- -- =========================================
-- SELECT * FROM user_db_links;

-- -- =========================================
-- -- Tester la connexion vers SITE1
-- -- =========================================
-- SELECT * FROM dual@site1;

-- DROP DATABASE LINK SITE1_LINK;

-- CREATE DATABASE LINK SITE1_LINK
-- CONNECT TO system IDENTIFIED BY oracle
-- USING '(DESCRIPTION=
--   (ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1528))
--   (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
-- )';
-- SELECT * FROM dual@SITE1_LINK;

-- -- 2
-- DROP DATABASE LINK SITE1_LINK;

-- CREATE DATABASE LINK SITE1_LINK
-- CONNECT TO system IDENTIFIED BY oracle
-- USING '(DESCRIPTION=
--   (ADDRESS=(PROTOCOL=TCP)(HOST=eshop_site1_db)(PORT=1521))
--   (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
-- )';
-- -- CREATE DATABASE LINK site1
-- -- CONNECT TO system IDENTIFIED BY oracle
-- -- USING 'XE';

-- -- BEGIN
-- --    EXECUTE IMMEDIATE 'DROP DATABASE LINK site2';
-- -- EXCEPTION
-- --    WHEN OTHERS THEN NULL;
-- -- END;
-- -- /
-- -- SELECT * FROM user_db_links;
-- -- SELECT * FROM dual@site1;
