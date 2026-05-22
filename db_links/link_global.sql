/* =========================================
   DATABASE LINK : GLOBAL ACCESS
   ========================================= */

CREATE DATABASE LINK SITE_GLOBAL_LINK
CONNECT TO system IDENTIFIED BY oracle
USING '(DESCRIPTION=
  (ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521))
  (CONNECT_DATA=(SERVICE_NAME=XEPDB1))
)';

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

-- SELECT db_link, username, host
-- FROM user_db_links;

-- SELECT * FROM dual@site1;
-- SELECT * FROM dual@site2;