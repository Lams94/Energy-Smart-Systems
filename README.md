# energy_smart_systems

Application mobile de gestion des dossiers d'étude de raccordement ENEDIS

# Energy Smart Systems (ESS) Mobile App

Application mobile Flutter pour Energy Smart Systems avec thème graphique officiel ESS.

## 🎨 Charte Graphique ESS

### Couleurs Officielles
- **Fond principal** : `#0A0A0A` (noir profond ESS)
- **Accent principal** : `#3ADF7C` (vert pro dynamique)
- **Accent secondaire** : `#00B8D9` (cyan technique lumineux)
- **Surface composant** : `#1A1A1A` (fond carte)
- **Texte principal** : `#FFFFFF` (blanc pur)
- **Texte secondaire** : `#B0B0B0` (gris clair)
- **Erreur/Alerte** : `#FF4D4F`
- **Succès** : `#4ADE80`

### Typographie
- **Titres** : Poppins (bold/semibold)
- **Texte courant** : Inter (normal/medium)
- **Données techniques** : Roboto Mono / Inter Mono

## 📱 Fonctionnalités

- Interface utilisateur avec thème ESS complet
- Navigation bottom bar personnalisée
- FloatingActionButton aux couleurs ESS
- AppBar avec branding ESS
- Logo stylisé avec effets visuels
- Cartes avec bordures et ombres ESS

## 🚀 Installation et Build

### Prérequis
- Flutter 3.32.6+
- Android SDK Platform 35
- Build-tools 35.0.0
- Android Studio ou VS Code

### Build APK
```bash
flutter clean
flutter build apk --debug
```

### Installation sur appareil
```bash
adb install -r build/app/outputs/flutter-apk/app-debug.apk
```

### Lancement
```bash
adb shell monkey -p com.energysmart.energy_smart_systems -c android.intent.category.LAUNCHER 1
```

## 🔧 Scripts Utiles

- `build_ess_colors.ps1` - Build avec couleurs ESS
- `fix_android_issues.ps1` - Résolution problèmes Android
- `build_and_test.ps1` - Build et test complet

## 📋 Configuration Android

- **Min SDK** : 23
- **Target SDK** : 35
- **Compile SDK** : 35
- **Package** : `com.energysmart.energy_smart_systems`

## 🔄 Versions

### v0.0.1 (2025-07-20)
- ✅ Application de base Flutter
- ✅ Thème ESS complet appliqué
- ✅ Configuration Android optimisée
- ✅ Build et installation fonctionnels
- ✅ Interface utilisateur ESS

## 🛠️ Développement

Structure du projet :
```
lib/
├── main.dart                 # Point d'entrée avec thème ESS
├── core/
│   ├── constants/
│   │   └── app_colors.dart   # Couleurs ESS
│   └── theme/
│       └── app_theme.dart    # Thème Material 3 ESS
└── presentation/
    └── widgets/              # Widgets ESS personnalisés
```

## 📄 Licence

Energy Smart Systems - Application mobile officielle
