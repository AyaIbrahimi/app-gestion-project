# 🚀 Guide DevOps Simplifié - DXC Platform

Ce document résume de manière **simple et rapide** les 6 étapes (Jobs) du pipeline d'intégration et de déploiement automatiques (CI/CD).

---

## ⚡ En résumé : Que font les 6 Jobs ?

```
1. Tests Backend (Java) ──┐
                          ├──> 3. Scans Sécurité ──> 4. Images Docker ──> 5. Staging (Test) ──> 6. Production (Blue-Green)
2. Build Frontend (Web) ──┘
```

---

### 🟢 1. `backend-ci` (Tests Java)
- Vérifie et teste le code Java / Spring Boot.
- Garantit qu'il n'y a pas d'erreurs dans le Backend.

### 🟢 2. `frontend-ci` (Build Web)
- Installe et compile l'application Angular.
- Garantit que la page web se génère sans bug.

### 🛡️ 3. `security-scan` (Sécurité)
- **Trufflehog** : Détecte si un mot de passe ou une clé d'API a été oublié dans le code.
- **Trivy** : Cherche les vulnérabilités dans le code et les dépendances.

### 🐳 4. `build-and-push` (Création Docker)
- Fabrique les conteneurs Docker (Backend + Frontend).
- Les publie en toute sécurité sur le registre GitHub (`ghcr.io`).

### 🧪 5. `deploy-staging` (Environnement de Test)
- Déploie l'application temporairement avec une vraie base de données PostgreSQL.
- Simule des attaques avec **OWASP ZAP** pour valider la robustesse de l'API.

### 🔄 6. `deploy-production` (Déploiement Blue-Green & Rollback)
- **Zéro Coupure** : Bascule le trafic Nginx de l'ancienne version (Blue) vers la nouvelle version (Green) sans déconnecter les utilisateurs.
- **Sécurité Rollback** : Si le démarrage échoue, le système revient automatiquement à l'ancienne version stable.

---

## 📁 Les 3 Fichiers Clés à Connaître

- 📄 **`.github/workflows/ci-cd.yml`** : Fichier principal qui lance les 6 Jobs.
- 📜 **`scripts/deploy-blue-green.sh`** : Script qui gère le basculement sans coupure.
- 🛡️ **`scripts/rollback.sh`** : Script d'urgence qui restaure l'ancienne version en cas de bug.
