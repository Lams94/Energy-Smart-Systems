# 📄 SPÉCIFICATION FONCTIONNELLE COMPLÈTE – APPLICATION MOBILE & WEB

## Energy Smart Systems

**Responsable produit** : Lamine Sané  
**Version** : 1.0  
**Date** : 17/07/2025

---

## 🎯 1. Objectif

Développer une application mobile (et éventuellement un back-office web) pour :

* Gérer les dossiers d'étude de raccordement ENEDIS
* Permettre aux collaborateurs de postuler ou recevoir des missions
* Suivre l'avancement des études et des étapes techniques
* Automatiser l'attribution, le suivi de facturation et le pilotage du chiffre d'affaires

---

## 👤 2. Types d'utilisateurs

| Rôle                           | Description                                                                          |
| ------------------------------ | ------------------------------------------------------------------------------------ |
| **Admin**                      | Gère l'ensemble des dossiers, valide les affectations, consulte les performances     |
| **Collaborateur / Partenaire** | Postule à des missions, gère ses dossiers, remplit les étapes, voit ses performances |

---

## 🧩 3. Fonctionnalités principales

### 📁 3.1. Gestion des dossiers

* Création ou import manuel depuis le portail Enedis
* Données par dossier :
  * Numéro OSR
  * Adresse
  * Département
  * Contact client
  * Nature de la demande
  * Solution Enedis envisagée
  * Date limite de rendu
  * Documents joints (devis, courrier, photos, rapport)

---

### ✅ 3.2. Étapes à suivre par dossier

| Étape               | Données          |
| ------------------- | ---------------- |
| Étude en cours      | ✅ / 📅           |
| Visite technique    | 📅 / Commentaire |
| Rapport rédigé      | 📎 PDF           |
| FSS reçu            | ✅ / 📎           |
| Facturation validée | Montant / ✅      |
| Paiement reçu       | ✅                |

---

### 🔄 3.3. Attribution intelligente des missions

#### ⚙️ Processus :

1. Admin crée un dossier (mission)
2. Tous les **utilisateurs éligibles** reçoivent une notification push
3. Ils ne voient que : numéro de dossier, adresse, département, date limite
4. Ils peuvent **postuler**
5. Si personne n'a postulé en **24h**, une attribution automatique est faite au **meilleur profil**

#### 🔒 Informations visibles avant acceptation :

* Numéro de dossier
* Adresse
* Département
* Date limite de rendu

---

### 📋 3.4. Critères d'éligibilité à une mission

| Règle                           | Condition                                              |
| ------------------------------- | ------------------------------------------------------ |
| Nombre max de dossiers en cours | 5                                                      |
| Bonus +20% dossiers             | Note moyenne ≥ 4.5 & ≥ 10 dossiers réalisés            |
| Blocage automatique             | Si 3 refus ou inactivité consécutifs                   |
| Rotation équitable              | Priorité à ceux qui ont reçu peu de missions récemment |

---

### 🚦 3.5. Notifications automatiques

| Événement                    | Notification                       |
| ---------------------------- | ---------------------------------- |
| Nouvelle mission disponible  | Envoyée aux utilisateurs éligibles |
| Rappel 48h avant date limite | À l'utilisateur affecté            |
| Affectation automatique      | Si mission ignorée pendant 24h     |
| Blocage temporaire           | Si 3 refus consécutifs             |

---

### 📊 3.6. Suivi du chiffre d'affaires

| Indicateur               | Portée                   |
| ------------------------ | ------------------------ |
| Chiffre d'affaires total | Global ou par mois       |
| Par collaborateur        | Volume facturé / payé    |
| Factures à relancer      | Liste filtrable          |
| Taux de paiement         | % CA encaissé vs facturé |

---

### ⭐ 3.7. Performance des collaborateurs

Chaque utilisateur voit :

* Nombre de missions terminées
* Note moyenne (qualité / délai / communication)
* Taux de respect des délais
* Rapport de performance mensuel

---

### 🛡️ 3.8. Sécurité & RGPD

* Authentification sécurisée (Firebase ou autre)
* Les infos client ne sont visibles **qu'après affectation**
* Audit log des actions
* Données cryptées au repos et en transit

---

## 🧱 4. Architecture technique recommandée

| Composant             | Stack recommandée                   |
| --------------------- | ----------------------------------- |
| Application mobile    | Flutter (Android/iOS)               |
| Back-end API          | FastAPI (Python)                    |
| Base de données       | PostgreSQL ou Firebase Firestore    |
| Authentification      | Firebase Auth                       |
| Stockage fichiers     | Firebase Storage                    |
| Notifications         | Firebase Cloud Messaging            |
| Admin web (optionnel) | React + Tailwind CSS ou Flutter Web |

---

## 🎨 5. Identité visuelle & thème de l'application

### Palette de couleurs (extrait du logo) :

| Élément UI                   | Couleur                  | Code HEX               |
| ---------------------------- | ------------------------ | ---------------------- |
| Fond principal               | Bleu nuit / noir profond | `#0A0A0A` ou `#101820` |
| Accent vert clair            | Vert pro / dynamique     | `#3ADF7C` ou `#2ECC71` |
| Accent vert foncé            | Vert forêt technique     | `#118D57`              |
| Turquoise technique (option) | Cyan / bleu vert         | `#00B8D9`              |
| Texte principal              | Blanc                    | `#FFFFFF`              |
| Texte secondaire             | Gris clair               | `#C0C0C0`              |

### Recommandations UI :

* Design sobre, professionnel, lisible
* Polices : **Poppins**, **Inter** ou **Montserrat**
* Icônes simples et vectorielles
* Boutons : vert pour actions primaires, gris pour secondaires
* Coins arrondis, ombres douces, animations légères

---

## 📲 6. Interfaces prévues

### **Application mobile collaborateur**

* Accueil : missions en cours / disponibles
* Candidature à mission
* Détail mission + remplissage étapes
* Upload FSS, rapport
* Statistiques personnelles

### **Panel admin (mobile ou web)**

* Création de dossiers
* Suivi candidatures
* Attribution manuelle ou automatique
* Tableau de bord CA et perf utilisateurs

---

## 📦 7. Livrables attendus

* Application Flutter (mobile)
* API REST (FastAPI) + BDD déployée
* Back-office simple (web, optionnel)
* Documentation du code + accès à la BDD
* Export CSV des données
* Rapports mensuels auto générés

---

## 📋 8. Règles métiers détaillées

### 8.1. Gestion des utilisateurs

#### Collaborateurs
- Inscription avec validation admin
- Profil avec compétences et zones géographiques
- Historique des missions
- Système de notation

#### Administrateurs
- Gestion complète des utilisateurs
- Attribution manuelle ou automatique
- Suivi global des performances
- Gestion des paiements

### 8.2. Workflow des missions

#### Création d'une mission
1. Admin saisit les informations de base
2. Système détermine les utilisateurs éligibles
3. Notification push envoyée
4. Période de candidature de 24h
5. Attribution automatique si pas de candidat

#### Suivi d'une mission
1. Utilisateur accepte la mission
2. Accès aux informations complètes du client
3. Suivi des étapes avec horodatage
4. Upload des documents requis
5. Validation finale par l'admin

### 8.3. Système de notifications

#### Types de notifications
- **Push** : Nouvelle mission, rappels, alertes
- **In-app** : Mises à jour des statuts
- **Email** : Rapports mensuels, factures

#### Paramétrage
- Fréquence personnalisable
- Types de notifications configurables
- Zones géographiques d'intérêt

### 8.4. Calculs et indicateurs

#### Performance individuelle
```
Note globale = (Note qualité + Note délai + Note communication) / 3
Bonus éligibilité = Note ≥ 4.5 ET Missions ≥ 10
Malus = 3 refus consécutifs → Suspension temporaire
```

#### Chiffre d'affaires
```
CA mensuel = Σ(Montant facturé par mission du mois)
Taux de paiement = (CA encaissé / CA facturé) × 100
Commission = % du CA selon barème défini
```

---

## 🔧 9. Spécifications techniques détaillées

### 9.1. Structure de données

#### Modèle Utilisateur
```json
{
  "id": "string",
  "email": "string",
  "nom": "string",
  "prenom": "string",
  "role": "admin|collaborateur",
  "telephone": "string",
  "adresse": "object",
  "competences": ["array"],
  "zones_intervention": ["array"],
  "note_moyenne": "float",
  "missions_terminees": "int",
  "missions_en_cours": "int",
  "date_creation": "timestamp",
  "statut": "actif|suspendu|inactif"
}
```

#### Modèle Mission
```json
{
  "id": "string",
  "numero_osr": "string",
  "adresse": "object",
  "departement": "string",
  "contact_client": "object",
  "nature_demande": "string",
  "solution_enedis": "string",
  "date_limite": "timestamp",
  "date_creation": "timestamp",
  "statut": "disponible|attribuee|en_cours|terminee",
  "utilisateur_assigne": "string|null",
  "etapes": "object",
  "documents": ["array"],
  "montant_facture": "float",
  "date_paiement": "timestamp|null"
}
```

### 9.2. API Endpoints

#### Authentification
- `POST /auth/login` - Connexion
- `POST /auth/logout` - Déconnexion
- `POST /auth/register` - Inscription (collaborateur)
- `GET /auth/profile` - Profil utilisateur

#### Missions
- `GET /missions` - Liste des missions (filtrées selon le rôle)
- `POST /missions` - Créer une mission (admin)
- `GET /missions/{id}` - Détail d'une mission
- `PUT /missions/{id}` - Mettre à jour une mission
- `POST /missions/{id}/apply` - Candidater à une mission
- `POST /missions/{id}/assign` - Attribuer une mission (admin)

#### Documents
- `POST /missions/{id}/documents` - Upload de document
- `GET /documents/{id}` - Télécharger un document
- `DELETE /documents/{id}` - Supprimer un document

#### Notifications
- `GET /notifications` - Liste des notifications
- `PUT /notifications/{id}/read` - Marquer comme lue
- `POST /notifications/preferences` - Paramétrer les notifications

### 9.3. Sécurité

#### Authentification
- JWT avec refresh token
- Session timeout configurable
- Authentification à deux facteurs (optionnel)

#### Autorisation
- RBAC (Role-Based Access Control)
- Permissions granulaires par endpoint
- Validation des données côté serveur

#### Protection des données
- Cryptage AES-256 pour les données sensibles
- HTTPS obligatoire
- Logs d'audit pour toutes les actions
- Conformité RGPD (droit à l'oubli, portabilité)

---

## 🚀 10. Plan de développement

### Phase 1 : Fondations (4 semaines)
- [ ] Setup du projet Flutter
- [ ] Architecture de base
- [ ] Authentification
- [ ] Navigation
- [ ] Interface de base

### Phase 2 : Gestion des missions (6 semaines)
- [ ] CRUD missions
- [ ] Système de candidature
- [ ] Notifications push
- [ ] Upload de documents
- [ ] Interface admin

### Phase 3 : Fonctionnalités avancées (4 semaines)
- [ ] Système de notation
- [ ] Tableaux de bord
- [ ] Rapports
- [ ] Attribution automatique
- [ ] Optimisations

### Phase 4 : Tests et déploiement (2 semaines)
- [ ] Tests unitaires et d'intégration
- [ ] Tests utilisateur
- [ ] Déploiement production
- [ ] Documentation utilisateur

---

## 📞 11. Contact et support

**Product Owner** : Lamine Sané  
**Email** : [email]  
**Téléphone** : [téléphone]

---

*Ce document constitue la référence fonctionnelle complète pour le développement de l'application Energy Smart Systems. Il sera mis à jour au fur et à mesure de l'avancement du projet.*
