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


--Vérification des Database Links
SELECT DB_LINK, USERNAME, HOST 
FROM USER_DB_LINKS 
ORDER BY DB_LINK;



