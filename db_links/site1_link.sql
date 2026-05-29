
/* =========================================
            DATABASE LINK 
   ========================================= */


-- Lien vers GLOBALE
PROMPT 'Creation SITE_GLOBAL vers eshop_global_db...'
CREATE DATABASE LINK SITE_GLOBAL
    CONNECT TO system IDENTIFIED BY oracle
    USING '(DESCRIPTION=
        (ADDRESS=(PROTOCOL=TCP)(HOST=eshop_global_db)(PORT=1521))
        (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
    )';

-- Lien vers SITE2
PROMPT 'Creation SITE2 vers eshop_site2_db...'
CREATE DATABASE LINK SITE2
    CONNECT TO system IDENTIFIED BY oracle
    USING '(DESCRIPTION=
        (ADDRESS=(PROTOCOL=TCP)(HOST=eshop_site2_db)(PORT=1521))
        (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
    )';

-- ============================================================================
-- FICHIER: recreate_links_site1.sql
-- BASE: SITE1 (eshop_site1_db)
-- OBJECTIF: Nettoyer et recréer les liens vers GLOBALE et SITE2
-- ============================================================================

-- SET SERVEROUTPUT ON;
-- SET LINESIZE 200;

-- PROMPT ============================================================================
-- PROMPT RECONFIGURATION DES DATABASE LINKS SUR SITE1
-- PROMPT ============================================================================

-- -- 1. Suppression des anciens links
-- PROMPT 1. Suppression des anciens liens...
-- BEGIN
--     BEGIN EXECUTE IMMEDIATE 'DROP DATABASE LINK SITE_GLOBAL'; EXCEPTION WHEN OTHERS THEN NULL; END;
--     BEGIN EXECUTE IMMEDIATE 'DROP DATABASE LINK SITE2'; EXCEPTION WHEN OTHERS THEN NULL; END;
--     BEGIN EXECUTE IMMEDIATE 'DROP DATABASE LINK SITE1'; EXCEPTION WHEN OTHERS THEN NULL; END;
--     BEGIN EXECUTE IMMEDIATE 'DROP DATABASE LINK SITE1_LINK'; EXCEPTION WHEN OTHERS THEN NULL; END;
--     DBMS_OUTPUT.PUT_LINE(' Anciens liens supprimes');
-- END;
-- /

-- -- 2. Création des nouveaux links
-- PROMPT 2. Creation des nouveaux liens...

-- -- Lien vers GLOBALE
-- PROMPT 'Creation SITE_GLOBAL vers eshop_global_db...'
-- CREATE DATABASE LINK SITE_GLOBAL
--     CONNECT TO system IDENTIFIED BY oracle
--     USING '(DESCRIPTION=
--         (ADDRESS=(PROTOCOL=TCP)(HOST=eshop_global_db)(PORT=1521))
--         (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
--     )';

-- -- Lien vers SITE2
-- PROMPT 'Creation SITE2 vers eshop_site2_db...'
-- CREATE DATABASE LINK SITE2
--     CONNECT TO system IDENTIFIED BY oracle
--     USING '(DESCRIPTION=
--         (ADDRESS=(PROTOCOL=TCP)(HOST=eshop_site2_db)(PORT=1521))
--         (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
--     )';

-- -- 3. Vérification
-- PROMPT 3. Verification...
-- COLUMN DB_LINK FORMAT A20
-- SELECT DB_LINK, HOST FROM USER_DB_LINKS;

-- -- 4. Tests
-- PROMPT 4. Tests des connexions...
-- DECLARE
--     v_test NUMBER;
-- BEGIN
--     BEGIN EXECUTE IMMEDIATE 'SELECT 1 FROM DUAL@SITE_GLOBAL' INTO v_test;
--         DBMS_OUTPUT.PUT_LINE(' SITE1 → GLOBALE: CONNECTE');
--     EXCEPTION WHEN OTHERS THEN 
--         DBMS_OUTPUT.PUT_LINE(' SITE1 → GLOBALE: ' || SQLERRM);
--     END;
    
--     BEGIN EXECUTE IMMEDIATE 'SELECT 1 FROM DUAL@SITE2' INTO v_test;
--         DBMS_OUTPUT.PUT_LINE(' SITE1 → SITE2: CONNECTE');
--     EXCEPTION WHEN OTHERS THEN 
--         DBMS_OUTPUT.PUT_LINE(' SITE1 → SITE2: ' || SQLERRM);
--     END;
-- END;
-- /
-- SELECT DB_LINK, USERNAME, HOST 
-- FROM USER_DB_LINKS 
-- ORDER BY DB_LINK;

-- PROMPT ============================================================================
-- PROMPT FIN CONFIGURATION SITE1
-- PROMPT ============================================================================

-- -- Connexion à SITE1
-- -- docker exec -it eshop_site1_db sqlplus system/oracle@XEPDB1

-- SET SERVEROUTPUT ON;

-- -- Test Site1 → Globale
-- BEGIN
--     EXECUTE IMMEDIATE 'SELECT 1 FROM DUAL@SITE_GLOBAL';
--     DBMS_OUTPUT.PUT_LINE(' SITE1 → GLOBALE: CONNECTE');
-- EXCEPTION
--     WHEN OTHERS THEN
--         DBMS_OUTPUT.PUT_LINE(' SITE1 → GLOBALE: NON CONNECTE - ' || SQLERRM);
-- END;
-- /

-- -- Test Site1 → Site2
-- BEGIN
--     EXECUTE IMMEDIATE 'SELECT 1 FROM DUAL@SITE2';
--     DBMS_OUTPUT.PUT_LINE(' SITE1 → SITE2: CONNECTE');
-- EXCEPTION
--     WHEN OTHERS THEN
--         DBMS_OUTPUT.PUT_LINE(' SITE1 → SITE2: NON CONNECTE - ' || SQLERRM);
-- END;
-- /

-- -- Test Site1 → Site1 (elle-même)
-- BEGIN
--     EXECUTE IMMEDIATE 'SELECT 1 FROM DUAL';
--     DBMS_OUTPUT.PUT_LINE(' SITE1 → SITE1: CONNECTE');
-- EXCEPTION
--     WHEN OTHERS THEN
--         DBMS_OUTPUT.PUT_LINE(' SITE1 → SITE1: NON CONNECTE');
-- END;
-- /

-- -- Vérification avec requêtes directes
-- SELECT 'Site1 → Globale OK' as Test FROM DUAL@SITE_GLOBAL;
-- SELECT 'Site1 → Site2 OK' as Test FROM DUAL@SITE2;

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
