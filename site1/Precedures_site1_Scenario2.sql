-- =========================================
-- Procédures : INSERT, DELETE, UPDATE
-- =========================================

-- =========================================
--  INSERTION SITE 1
-- =========================================
CREATE OR REPLACE PROCEDURE insertligne1_scenario2(
    p_idlignecommande NUMBER,
    p_idcommande NUMBER,
    p_idproduit NUMBER,
    p_quantite NUMBER,
    p_remise NUMBER
)
IS
    v_count NUMBER;
    v_idclient NUMBER;
    
    exception_quantite EXCEPTION;
    PRAGMA EXCEPTION_INIT(exception_quantite, -20002);
BEGIN
    -- CONTRÔLE SITE1 : Quantité >= 100
    IF p_quantite < 100 THEN
        RAISE_APPLICATION_ERROR(-20002, 
            'Erreur: Quantité ' || p_quantite || ' invalide pour Site1 (doit être >= 100)');
    END IF;

    -- Récupérer client depuis SITE GLOBAL
    SELECT idclient INTO v_idclient
    FROM Commandes@site_global
    WHERE idcommande = p_idcommande;

    -- CLIENTS1 (Vérification et insertion locale)
    SELECT COUNT(*) INTO v_count FROM Clients1 WHERE idclient = v_idclient;
    IF v_count = 0 THEN
        INSERT INTO Clients1 SELECT * FROM Clients@site_global WHERE idclient = v_idclient;
    END IF;

    -- PRODUITS1
    SELECT COUNT(*) INTO v_count FROM Produits1 WHERE idproduit = p_idproduit;
    IF v_count = 0 THEN
        INSERT INTO Produits1 SELECT * FROM Produits@site_global WHERE idproduit = p_idproduit;
    END IF;

    -- COMMANDES1
    SELECT COUNT(*) INTO v_count FROM Commandes1 WHERE idcommande = p_idcommande;
    IF v_count = 0 THEN
        INSERT INTO Commandes1 SELECT * FROM Commandes@site_global WHERE idcommande = p_idcommande;
    END IF;

    -- INSERTION FINALE
    INSERT INTO LigneCommandes1 VALUES (p_idlignecommande, p_idcommande, p_idproduit, p_quantite, p_remise);
    
    DBMS_OUTPUT.PUT_LINE(' Insertion réussie SITE 1 (Gros volume) : Ligne ' || p_idlignecommande || ' Quantité=' || p_quantite);

EXCEPTION
    WHEN exception_quantite THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [STOP] Quantité insuffisante pour Site1 (doit être >= 100)');
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [ERREUR] Produit/Commande inexistant dans base globale');
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [ERREUR] ID ligne ' || p_idlignecommande || ' existe déjà');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [ERREUR] Problème technique : ' || SQLERRM);
END;
/

-- =========================================
--  SUPPRESSION SITE 1
-- =========================================
CREATE OR REPLACE PROCEDURE deleteligne1_scenario2(
    p_idlignecommande NUMBER
)
IS
    v_count NUMBER;
    exception_not_found EXCEPTION;
    PRAGMA EXCEPTION_INIT(exception_not_found, -20010);
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM LigneCommandes1
    WHERE idlignecommande = p_idlignecommande;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010, 'Ligne ' || p_idlignecommande || ' inexistante');
    END IF;

    DELETE FROM LigneCommandes1 WHERE idlignecommande = p_idlignecommande;
    DBMS_OUTPUT.PUT_LINE(' Suppression réussie SITE 1 : Ligne ' || p_idlignecommande);

EXCEPTION
    WHEN exception_not_found THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [STOP] Ligne inexistante dans Site1');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [ERREUR] ' || SQLERRM);
END;
/

-- =========================================
--  UPDATE SITE 1
-- =========================================
CREATE OR REPLACE PROCEDURE updateligne1_scenario2(
    p_idlignecommande NUMBER,
    p_idproduit NUMBER,
    p_quantite NUMBER,
    p_remise NUMBER
)
IS
    v_count NUMBER;
    exception_not_found EXCEPTION;
    exception_quantite EXCEPTION;
    PRAGMA EXCEPTION_INIT(exception_quantite, -20021);
BEGIN
    -- Vérifier existence
    SELECT COUNT(*) INTO v_count
    FROM LigneCommandes1
    WHERE idlignecommande = p_idlignecommande;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20020, 'Ligne ' || p_idlignecommande || ' inexistante');
    END IF;

    -- Contrôle quantité Site1
    IF p_quantite < 100 THEN
        RAISE_APPLICATION_ERROR(-20021, 
            'Quantité ' || p_quantite || ' invalide pour Site1 (doit être >= 100)');
    END IF;

    -- Mise à jour
    UPDATE LigneCommandes1
    SET idproduit = p_idproduit,
        quantite = p_quantite,
        remise = p_remise
    WHERE idlignecommande = p_idlignecommande;

    DBMS_OUTPUT.PUT_LINE(' Mise à jour réussie SITE 1 : Ligne ' || p_idlignecommande || ' Quantité=' || p_quantite);

EXCEPTION
    WHEN exception_not_found THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [STOP] Ligne inexistante');
    WHEN exception_quantite THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [STOP] Quantité < 100 non autorisée pour Site1');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [ERREUR] ' || SQLERRM);
END;
/