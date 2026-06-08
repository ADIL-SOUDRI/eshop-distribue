-- =========================================
-- SITE 2 - PETITS VOLUMES (Quantite < 100)
-- =========================================

-- =========================================
--  INSERTION SITE 2
-- =========================================
CREATE OR REPLACE PROCEDURE insertligne2_scenario2(
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
    PRAGMA EXCEPTION_INIT(exception_quantite, -20003);
BEGIN
    -- CONTRÔLE SITE2 : Quantité < 100
    IF p_quantite >= 100 THEN
        RAISE_APPLICATION_ERROR(-20003, 
            'Erreur: Quantité ' || p_quantite || ' invalide pour Site2 (doit être < 100)');
    END IF;

    -- Récupérer client depuis SITE GLOBAL
    SELECT idclient INTO v_idclient
    FROM Commandes@site_global
    WHERE idcommande = p_idcommande;

    -- CLIENTS2
    SELECT COUNT(*) INTO v_count FROM Clients2 WHERE idclient = v_idclient;
    IF v_count = 0 THEN
        INSERT INTO Clients2 SELECT * FROM Clients@site_global WHERE idclient = v_idclient;
    END IF;

    -- PRODUITS2
    SELECT COUNT(*) INTO v_count FROM Produits2 WHERE idproduit = p_idproduit;
    IF v_count = 0 THEN
        INSERT INTO Produits2 SELECT * FROM Produits@site_global WHERE idproduit = p_idproduit;
    END IF;

    -- COMMANDES2
    SELECT COUNT(*) INTO v_count FROM Commandes2 WHERE idcommande = p_idcommande;
    IF v_count = 0 THEN
        INSERT INTO Commandes2 SELECT * FROM Commandes@site_global WHERE idcommande = p_idcommande;
    END IF;

    -- INSERTION FINALE
    INSERT INTO LigneCommandes2 VALUES (p_idlignecommande, p_idcommande, p_idproduit, p_quantite, p_remise);
    
    DBMS_OUTPUT.PUT_LINE(' Insertion réussie SITE 2 (Petit volume) : Ligne ' || p_idlignecommande || ' Quantité=' || p_quantite);

EXCEPTION
    WHEN exception_quantite THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [STOP] Quantité >= 100 non autorisée pour Site2');
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [ERREUR] Produit/Commande inexistant');
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [ERREUR] ID ligne ' || p_idlignecommande || ' existe déjà');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [ERREUR] ' || SQLERRM);
END;
/

-- =========================================
--  SUPPRESSION SITE 2
-- =========================================
CREATE OR REPLACE PROCEDURE deleteligne2_scenario2(
    p_idlignecommande NUMBER
)
IS
    v_count NUMBER;
    exception_not_found EXCEPTION;
    PRAGMA EXCEPTION_INIT(exception_not_found, -20011);
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM LigneCommandes2
    WHERE idlignecommande = p_idlignecommande;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20011, 'Ligne ' || p_idlignecommande || ' inexistante');
    END IF;

    DELETE FROM LigneCommandes2 WHERE idlignecommande = p_idlignecommande;
    DBMS_OUTPUT.PUT_LINE(' Suppression réussie SITE 2 : Ligne ' || p_idlignecommande);

EXCEPTION
    WHEN exception_not_found THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [STOP] Ligne inexistante dans Site2');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [ERREUR] ' || SQLERRM);
END;
/

-- =========================================
--  UPDATE SITE 2
-- =========================================
CREATE OR REPLACE PROCEDURE updateligne2_scenario2(
    p_idlignecommande NUMBER,
    p_idproduit NUMBER,
    p_quantite NUMBER,
    p_remise NUMBER
)
IS
    v_count NUMBER;
    exception_not_found EXCEPTION;
    exception_quantite EXCEPTION;
    PRAGMA EXCEPTION_INIT(exception_quantite, -20022);
BEGIN
    -- Vérifier existence
    SELECT COUNT(*) INTO v_count
    FROM LigneCommandes2
    WHERE idlignecommande = p_idlignecommande;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20020, 'Ligne ' || p_idlignecommande || ' inexistante');
    END IF;

    -- Contrôle quantité Site2
    IF p_quantite >= 100 THEN
        RAISE_APPLICATION_ERROR(-20022, 
            'Quantité ' || p_quantite || ' invalide pour Site2 (doit être < 100)');
    END IF;

    -- Mise à jour
    UPDATE LigneCommandes2
    SET idproduit = p_idproduit,
        quantite = p_quantite,
        remise = p_remise
    WHERE idlignecommande = p_idlignecommande;

    DBMS_OUTPUT.PUT_LINE(' Mise à jour réussie SITE 2 : Ligne ' || p_idlignecommande || ' Quantité=' || p_quantite);

EXCEPTION
    WHEN exception_not_found THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [STOP] Ligne inexistante');
    WHEN exception_quantite THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [STOP] Quantité >= 100 non autorisée pour Site2');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' [ERREUR] ' || SQLERRM);
END;
/