-- 1️⃣ D'abord activer le trigger
ALTER TRIGGER SYC_INSERT_LIGNE ENABLE;

-- 2️⃣ Ensuite faire les insertions
INSERT INTO LigneCommandes VALUES (1001,101,1001,120,5);
INSERT INTO LigneCommandes VALUES (1002,101,1001,120,5);
INSERT INTO LigneCommandes VALUES (2001,300,2002,80,5);
INSERT INTO LigneCommandes VALUES (2002,300,2002,80,5);
-- ...

COMMIT;

SELECT trigger_name, status 
FROM user_triggers 
WHERE trigger_name = 'SYC_INSERT_LIGNE';
