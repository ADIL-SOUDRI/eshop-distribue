#  ESHOP DISTRIBUÉ — Projet Base de Données Avancée

##  Description

Ce projet implémente une base de données distribuée avec :

-  Fragmentation horizontale (Site1 / Site2)
-  Base globale de coordination
-  Triggers de distribution automatique
-  Procédures stockées PL/SQL
-  Database Links (Oracle)
-  Optimisation avec indexes + EXPLAIN PLAN
-  Requêtes analytiques distribuées

---

##  Architecture du projet

```
ESHOP_DISTRIBUE/
│
├── site_global/
├── site1/
├── site2/
├── db_links/
├── triggers/
├── global_queries/
├── optimization/
└── docker/
```

---

## Lancement du projet

### 1 Lancer Oracle avec Docker

```bash
docker compose up -d
```

#### Vérifier les containers

```bash
docker ps
```

#### Connexions Oracle

| Instance        | Host      | Port | Service Name | Username              | Password |
|-----------------|-----------|------|--------------|-----------------------|----------|
| eshop_global    | localhost | 1527 | XEPDP1       | system (ou sys as sysdba) | oracle   |
| eshop_site1     | localhost | 1528 | XEPDP1       | system (ou sys as sysdba) | oracle   |
| eshop_site2     | localhost | 1529 | XEPDP1       | system (ou sys as sysdba) | oracle   |

---

##  Initialisation

###  Site Global

```sql
@site_global/global_schema.sql
@site_global/constraints.sql
@site_global/db_links.sql
@site_global/test.sql
```

###  DB Links

```sql
@db_links/site1_link.sql
@db_links/site2_link.sql
@db_links/test_db_links.sql
```

###  Site 1

```sql
@site1/fragment_site1.sql
@site1/procedures_site1.sql
@site1/Precedures_site1_Scenario2.sql
@site1/test_site1.sql
```

###  Site 2

```sql
@site2/fragment_site2.sql
@site2/procedures_site2.sql
@site2/precedures_site2_Scenario2.sql
@site2/test_site2.sql
```

---

##  Triggers

### Activation par défaut (Scénario 1)

```sql
@triggers/trg_insert_ligne.sql
@triggers/trg_update_ligne.sql
@triggers/trg_delete_ligne.sql
```

### Scénario 2

```sql
@triggers/scenario2_trg_delete_ligne.sql
@triggers/scenario2_trg_insert_ligne.sql
@triggers/scenario2_trg_update_ligne.sql
```

---

##  Test des scénarios

```sql
@triggers/test_trigger.sql
```

###  Scénario 2 — Volume de vente

**Activer le Scénario 2 :**

```sql
ALTER TRIGGER SYC_INSERT_LIGNE_SC2 ENABLE;
ALTER TRIGGER SYC_UPDATE_LIGNE_SC2 ENABLE;
ALTER TRIGGER SYC_DELETE_LIGNE_SC2 ENABLE;
```

**Désactiver le Scénario 1 :**

```sql
ALTER TRIGGER SYC_INSERT_LIGNE DISABLE;
ALTER TRIGGER SYC_UPDATE_LIGNE DISABLE;
ALTER TRIGGER SYC_DELETE_LIGNE DISABLE;
```

Puis relancer les tests :

```sql
@triggers/test_trigger.sql
```

---

##  Optimisation

```sql
@optimization/5d_indexes.sql
@optimization/5b_explain_plan.sql
```

---

##  Requêtes globales

```sql
@global_queries/5a_commandes_par_clients.sql
@global_queries/6_requets_distrubie.sql
```
