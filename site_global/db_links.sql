-- Lien vers SITE1 (utilise le nom du conteneur et le port interne 1521)
PROMPT 'Creation SITE1_LINK vers eshop_site1_db...'
CREATE DATABASE LINK SITE1_LINK
    CONNECT TO system IDENTIFIED BY oracle
    USING '(DESCRIPTION=
        (ADDRESS=(PROTOCOL=TCP)(HOST=eshop_site1_db)(PORT=1521))
        (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
    )';

-- Lien vers SITE2 (utilise le nom du conteneur et le port interne 1521)
PROMPT 'Creation SITE2_LINK vers eshop_site2_db...'
CREATE DATABASE LINK SITE2_LINK
    CONNECT TO system IDENTIFIED BY oracle
    USING '(DESCRIPTION=
        (ADDRESS=(PROTOCOL=TCP)(HOST=eshop_site2_db)(PORT=1521))
        (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
    )';






-- -- ============================================================================
-- -- FICHIER: recreate_links_global.sql
-- -- BASE: GLOBALE (eshop_global_db)
-- -- OBJECTIF: Nettoyer et recréer tous les Database Links vers SITE1 et SITE2
-- -- ============================================================================

-- SET SERVEROUTPUT ON;
-- SET LINESIZE 200;
-- SET FEEDBACK ON;

-- PROMPT ============================================================================
-- PROMPT RECONFIGURATION DES DATABASE LINKS SUR LA BASE GLOBALE
-- PROMPT ============================================================================

-- -- ============================================================================
-- -- 1. SUPPRESSION DES ANCIENS LINKS
-- -- ============================================================================
-- PROMPT
-- PROMPT 1. Suppression des anciens Database Links...
-- PROMPT ----------------------------------------------------------------------------

-- BEGIN
--     -- Supprimer SITE1_LINK s'il existe
--     BEGIN
--         EXECUTE IMMEDIATE 'DROP DATABASE LINK SITE1_LINK';
--         DBMS_OUTPUT.PUT_LINE(' Supprimé: SITE1_LINK');
--     EXCEPTION
--         WHEN OTHERS THEN
--             DBMS_OUTPUT.PUT_LINE('  Non trouvé: SITE1_LINK');
--     END;
    
--     -- Supprimer SITE2_LINK s'il existe
--     BEGIN
--         EXECUTE IMMEDIATE 'DROP DATABASE LINK SITE2_LINK';
--         DBMS_OUTPUT.PUT_LINE(' Supprimé: SITE2_LINK');
--     EXCEPTION
--         WHEN OTHERS THEN
--             DBMS_OUTPUT.PUT_LINE('  Non trouvé: SITE2_LINK');
--     END;
    
--     -- Supprimer SITE_GLOBAL (lien vers elle-même - inutile)
--     BEGIN
--         EXECUTE IMMEDIATE 'DROP DATABASE LINK SITE_GLOBAL';
--         DBMS_OUTPUT.PUT_LINE(' Supprimé: SITE_GLOBAL (lien inutile)');
--     EXCEPTION
--         WHEN OTHERS THEN
--             DBMS_OUTPUT.PUT_LINE('  Non trouvé: SITE_GLOBAL');
--     END;
    
--     -- Supprimer SITE1 (lien avec configuration incorrecte)
--     BEGIN
--         EXECUTE IMMEDIATE 'DROP DATABASE LINK SITE1';
--         DBMS_OUTPUT.PUT_LINE(' Supprimé: SITE1');
--     EXCEPTION
--         WHEN OTHERS THEN
--             DBMS_OUTPUT.PUT_LINE('  Non trouvé: SITE1');
--     END;
    
--     -- Supprimer SITE2 (lien avec configuration incorrecte)
--     BEGIN
--         EXECUTE IMMEDIATE 'DROP DATABASE LINK SITE2';
--         DBMS_OUTPUT.PUT_LINE(' Supprimé: SITE2');
--     EXCEPTION
--         WHEN OTHERS THEN
--             DBMS_OUTPUT.PUT_LINE('  Non trouvé: SITE2');
--     END;
-- END;
-- /

-- -- ============================================================================
-- -- 2. CRÉATION DES NOUVEAUX LINKS
-- -- ============================================================================
-- PROMPT
-- PROMPT 2. Creation des nouveaux Database Links...
-- PROMPT ----------------------------------------------------------------------------

-- -- Lien vers SITE1 (utilise le nom du conteneur et le port interne 1521)
-- PROMPT 'Creation SITE1_LINK vers eshop_site1_db...'
-- CREATE DATABASE LINK SITE1_LINK
--     CONNECT TO system IDENTIFIED BY oracle
--     USING '(DESCRIPTION=
--         (ADDRESS=(PROTOCOL=TCP)(HOST=eshop_site1_db)(PORT=1521))
--         (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
--     )';

-- -- Lien vers SITE2 (utilise le nom du conteneur et le port interne 1521)
-- PROMPT 'Creation SITE2_LINK vers eshop_site2_db...'
-- CREATE DATABASE LINK SITE2_LINK
--     CONNECT TO system IDENTIFIED BY oracle
--     USING '(DESCRIPTION=
--         (ADDRESS=(PROTOCOL=TCP)(HOST=eshop_site2_db)(PORT=1521))
--         (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
--     )';

-- -- ============================================================================
-- -- 3. VÉRIFICATION DES LINKS CRÉÉS
-- -- ============================================================================
-- PROMPT
-- PROMPT 3. Verification des Database Links...
-- PROMPT ----------------------------------------------------------------------------

-- COLUMN DB_LINK FORMAT A20
-- COLUMN USERNAME FORMAT A15
-- COLUMN HOST FORMAT A60

-- SELECT DB_LINK, USERNAME, HOST 
-- FROM USER_DB_LINKS 
-- ORDER BY DB_LINK;

-- -- ============================================================================
-- -- 4. TEST DES CONNEXIONS
-- -- ============================================================================
-- PROMPT
-- PROMPT 4. Test des connexions...
-- PROMPT ----------------------------------------------------------------------------

-- DECLARE
--     v_test NUMBER;
-- BEGIN
--     -- Test vers SITE1
--     BEGIN
--         EXECUTE IMMEDIATE 'SELECT 1 FROM DUAL@SITE1_LINK' INTO v_test;
--         DBMS_OUTPUT.PUT_LINE(' GLOBALE → SITE1: CONNECTE (via SITE1_LINK)');
--     EXCEPTION
--         WHEN OTHERS THEN
--             DBMS_OUTPUT.PUT_LINE(' GLOBALE → SITE1: NON CONNECTE');
--             DBMS_OUTPUT.PUT_LINE('   Erreur: ' || SQLERRM);
--     END;
    
--     -- Test vers SITE2
--     BEGIN
--         EXECUTE IMMEDIATE 'SELECT 1 FROM DUAL@SITE2_LINK' INTO v_test;
--         DBMS_OUTPUT.PUT_LINE(' GLOBALE → SITE2: CONNECTE (via SITE2_LINK)');
--     EXCEPTION
--         WHEN OTHERS THEN
--             DBMS_OUTPUT.PUT_LINE(' GLOBALE → SITE2: NON CONNECTE');
--             DBMS_OUTPUT.PUT_LINE('   Erreur: ' || SQLERRM);
--     END;
-- END;
-- /

-- -- ============================================================================
-- -- 5. TESTS SUPPLÉMENTAIRES AVEC REQUÊTES
-- -- ============================================================================
-- PROMPT
-- PROMPT 5. Tests supplementaires...
-- PROMPT ----------------------------------------------------------------------------

-- -- Test simple avec DUAL
-- SELECT 'SITE1 est accessible' AS Test FROM DUAL@SITE1_LINK;
-- SELECT 'SITE2 est accessible' AS Test FROM DUAL@SITE2_LINK;

-- -- Afficher la date/heure depuis chaque site
-- SELECT SYSDATE AS Heure_SITE1 FROM DUAL@SITE1_LINK;
-- SELECT SYSDATE AS Heure_SITE2 FROM DUAL@SITE2_LINK;

-- -- ============================================================================
-- -- 6. RÉSUMÉ FINAL
-- -- ============================================================================
-- PROMPT
-- PROMPT ============================================================================
-- PROMPT RÉSUMÉ FINAL DES LINKS SUR LA BASE GLOBALE
-- PROMPT ============================================================================

-- BEGIN
--     DBMS_OUTPUT.PUT_LINE('');
--     DBMS_OUTPUT.PUT_LINE('Links configures sur GLOBALE:');
--     FOR link IN (SELECT DB_LINK, HOST FROM USER_DB_LINKS ORDER BY DB_LINK) LOOP
--         DBMS_OUTPUT.PUT_LINE('  → ' || link.DB_LINK || ' -> ' || link.HOST);
--     END LOOP;
-- END;
-- /

-- PROMPT
-- PROMPT ============================================================================
-- PROMPT FIN DE LA CONFIGURATION
-- PROMPT ============================================================================




-- CREATE DATABASE LINK site1_link
-- CONNECT TO system IDENTIFIED BY oracle
-- USING '(DESCRIPTION=
--   (ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1528))
--   (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
-- )';

-- CREATE DATABASE LINK site2_link
-- CONNECT TO system IDENTIFIED BY oracle
-- USING '(DESCRIPTION=
--   (ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1529))
--   (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
-- )';

