# =========================================================
# 🛒 ESHOP DISTRIBUÉ - PROJET BASE DE DONNÉES AVANCÉE
# =========================================================

## 📌 Description
Ce projet implémente une base de données distribuée avec :

- 🔹 Fragmentation horizontale (Site1 / Site2)
- 🔹 Base globale de coordination
- 🔹 Triggers de distribution automatique
- 🔹 Procédures stockées PL/SQL
- 🔹 Database Links (Oracle)
- 🔹 Optimisation avec indexes + EXPLAIN PLAN
- 🔹 Requêtes analytiques distribuées

---

# 🧠 Architecture du projet

ESHOP_DISTRIBUE/
│
├── site_global/
├── site1/
├── site2/
├── db_links/
├── triggers/
├── global_queries/
├── optimization/
├── docker/

---

# 🚀 LANCEMENT DU PROJET

## 1️⃣ Lancer Oracle avec Docker

```bash
docker compose up -d