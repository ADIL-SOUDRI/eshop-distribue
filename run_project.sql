/* =========================================================
   ESHOP DISTRIBUÉ - GUIDE D'EXECUTION COMPLET
   ========================================================= */

/* =========================
   1. GLOBAL DATABASE
   ========================= */
@site_global/global_schema.sql
@site_global/constraints.sql

/* =========================
   2. DB LINKS
   ========================= */
@db_links/site1_link.sql
@db_links/site2_link.sql
@db_links/test_db_links.sql


/* =========================
   3. SITE 1
   ========================= */
@site1/01_fragment_site1.sql
@site1/03_procedures_site1.sql
@site1/04_test_site1.sql

/* =========================
   4. SITE 2
   ========================= */
@site2/01_fragment_site2.sql
@site2/03_procedures_site2.sql
@site2/04_test_site2.sql

/* =========================
   5. TRIGGERS DISTRIBUÉS
   ========================= */
@triggers/trg_insert_ligne.sql
@triggers/trg_update_ligne.sql
@triggers/trg_delete_ligne.sql

/* =========================
   6. TEST TRIGGERS
   ========================= */
@triggers/test_triggers.sql

/* =========================
   7. OPTIMISATION
   ========================= */
@optimization/5b_indexes.sql
@optimization/5d_explain_plan.sql

/* =========================
   8. REQUÊTES GLOBALES
   ========================= */
@global_queries/5a_commandes_par_client.sql
@global_queries/6_requete_distribuee.sql

/* =========================
   FIN
   ========================= */

SELECT 'PROJET ESHOP EXECUTÉ AVEC SUCCÈS' FROM dual;