# 📚 GUIDE D'INSTALLATION ET DÉMARRAGE

## Energy Smart Systems - Application Flutter

### 🛠️ Prérequis

1. **Flutter SDK** (version 3.8.1 ou supérieure)
   ```bash
   flutter doctor
   ```

2. **IDE recommandé** : Visual Studio Code avec extensions Flutter/Dart

3. **Émulateur ou appareil** : Android/iOS ou Windows Desktop

### 📦 Installation

1. **Cloner le projet**
   ```bash
   git clone <repository-url>
   cd energy_smart_systems
   ```

2. **Installer les dépendances**
   ```bash
   flutter pub get
   ```

3. **Vérifier l'installation**
   ```bash
   flutter doctor
   flutter analyze
   ```

### 🚀 Démarrage rapide

1. **Lancer l'application**
   ```bash
   # Sur émulateur Android/iOS
   flutter run
   
   # Sur Windows Desktop
   flutter run -d windows
   
   # Sur navigateur web
   flutter run -d chrome
   ```

2. **Connexion de test**
   - Email : `admin@energysmart.com` ou `user@energysmart.com`
   - Mot de passe : `123456` (ou tout mot de passe > 6 caractères)

### 🔧 Configuration

#### Variables d'environnement
Créer un fichier `.env` à la racine :
```env
# Firebase Configuration (à venir)
FIREBASE_PROJECT_ID=energy-smart-systems
FIREBASE_API_KEY=your-api-key

# API Configuration
API_BASE_URL=https://api.energysmart.com
API_VERSION=v1
```

#### Configuration Firebase (optionnel)
1. Créer un projet Firebase
2. Ajouter les fichiers de configuration :
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`
   - `web/firebase-config.js`

### 📱 Fonctionnalités testables

#### 1. Authentification
- Écran de connexion avec validation
- Gestion des erreurs
- Navigation automatique vers le dashboard

#### 2. Dashboard
- Vue d'ensemble des missions et dossiers
- Statistiques simulées
- Actions rapides
- Navigation vers les différentes sections

#### 3. Missions
- Onglet "Mes missions" avec missions assignées
- Onglet "Disponibles" avec missions à candidater
- Détails des missions avec budgets et échéances

#### 4. Navigation
- Bottom navigation bar
- Navigation par routes avec GoRouter
- Écrans temporaires pour les sections en développement

### 🐛 Résolution des problèmes

#### Erreurs communes

1. **"Target of URI doesn't exist"**
   ```bash
   flutter clean
   flutter pub get
   ```

2. **"No connected devices"**
   - Vérifier que l'émulateur est démarré
   - Ou utiliser : `flutter run -d chrome`

3. **Erreurs de compilation**
   ```bash
   flutter analyze
   flutter pub deps
   ```

#### Commandes de débogage

```bash
# Nettoyer le cache
flutter clean

# Mettre à jour les dépendances
flutter pub upgrade

# Vérifier les dépendances
flutter pub deps

# Analyser le code
flutter analyze

# Formater le code
dart format .
```

### 📊 Structure des données

#### Utilisateurs de test
```dart
// Administrateur
{
  "email": "admin@energysmart.com",
  "role": "admin",
  "name": "Admin User"
}

// Collaborateur
{
  "email": "user@energysmart.com", 
  "role": "collaborator",
  "name": "John Doe"
}
```

#### Données simulées
- **5 missions** (3 assignées, 2 en cours)
- **8 missions disponibles** avec différents budgets
- **3 dossiers** avec différents statuts
- **Statistiques** calculées dynamiquement

### 🔄 Workflow de développement

1. **Développement**
   ```bash
   flutter run --hot-reload
   ```

2. **Tests**
   ```bash
   flutter test
   ```

3. **Build**
   ```bash
   flutter build apk --release
   flutter build windows --release
   ```

### 📱 Plateformes supportées

- ✅ **Android** (API 21+)
- ✅ **iOS** (iOS 12+)
- ✅ **Windows** (Windows 10+)
- ✅ **Web** (Chrome, Firefox, Safari)
- ⚠️ **macOS** (à configurer)
- ⚠️ **Linux** (à configurer)

### 🎨 Personnalisation

#### Thème
Modifier `lib/core/theme/app_theme.dart` pour personnaliser :
- Couleurs
- Typographie
- Espacements
- Composants

#### Couleurs
Modifier `lib/core/constants/app_colors.dart` pour changer la palette.

#### Constantes
Modifier `lib/core/constants/app_constants.dart` pour les paramètres métier.

---

*Guide mis à jour le 18 juillet 2025*
