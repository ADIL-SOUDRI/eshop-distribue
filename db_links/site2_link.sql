/* =========================================
   DATABASE LINK : SITE1
   ========================================= */

CREATE DATABASE LINK SITE1_LINK
CONNECT TO system IDENTIFIED BY oracle
USING '(DESCRIPTION=
  (ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521))
  (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
)';
CREATE DATABASE LINK site1_link
    CONNECT TO system IDENTIFIED BY oracle
    USING '(DESCRIPTION=
        (ADDRESS=(PROTOCOL=TCP)(HOST=eshop_site1_db)(PORT=1521))
        (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
    )';
-- -- Création d’un database link vers SITE2 (connexion distante)
-- CREATE DATABASE LINK site2
-- CONNECT TO system IDENTIFIED BY oracle
-- USING 'XE';
SELECT * FROM dual@SITE1_LINK;

-- Connexion à SITE2
-- docker exec -it eshop_site2_db sqlplus system/oracle@XEPDB1

-- SET SERVEROUTPUT ON;

-- Test Site2 → Globale
BEGIN
    EXECUTE IMMEDIATE 'SELECT 1 FROM DUAL@SITE_GLOBAL';
    DBMS_OUTPUT.PUT_LINE(' SITE2 → GLOBALE: CONNECTE');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' SITE2 → GLOBALE: NON CONNECTE - ' || SQLERRM);
END;
/

-- Test Site2 → Site1 (si configuré)
BEGIN
    EXECUTE IMMEDIATE 'SELECT 1 FROM DUAL@SITE1_LINK';
    DBMS_OUTPUT.PUT_LINE(' SITE2 → SITE1: CONNECTE');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' SITE2 → SITE1: NON CONNECTE (ou non configuré)');
END;
/

-- Test Site2 → Site2 (elle-même)
BEGIN
    EXECUTE IMMEDIATE 'SELECT 1 FROM DUAL';
    DBMS_OUTPUT.PUT_LINE(' SITE2 → SITE2: CONNECTE');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' SITE2 → SITE2: NON CONNECTE');
END;
/

-- Vérification avec requêtes directes
SELECT 'Site2 → Globale OK' as Test FROM DUAL@SITE_GLOBAL;

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