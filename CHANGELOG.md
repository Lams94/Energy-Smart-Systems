# Changelog - Energy Smart Systems Mobile App

Toutes les modifications notables de ce projet seront documentées dans ce fichier.

Le format est basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/),
et ce projet adhère au [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.1] - 2025-07-20

### Ajouté
- Application Flutter de base avec architecture propre
- Thème graphique complet Energy Smart Systems (ESS)
- Couleurs officielles ESS (#0A0A0A, #3ADF7C, #00B8D9)
- Configuration Material 3 avec thème sombre ESS
- Interface utilisateur responsive mobile-first
- AppBar personnalisée avec branding ESS
- FloatingActionButton aux couleurs ESS
- BottomNavigationBar avec accents verts ESS
- Logo ESS stylisé avec effets d'ombre
- Carte de démonstration avec bordures vertes
- Configuration Android optimisée (API 35, min SDK 23)
- Scripts PowerShell pour build et débogage
- Documentation complète du projet

### Techniques
- Flutter 3.32.6 (canal stable)
- Android SDK Platform 35
- Build-tools 35.0.0
- Configuration Gradle Kotlin DSL
- Support Material 3 avec ColorScheme.dark
- Typographie Poppins/Inter selon charte ESS

### Résolu
- Problèmes "Could not locate aapt"
- Erreurs AndroidManifest.xml manquant
- Configuration correcte des build-tools Android
- Création automatique des répertoires d'assets
- Optimisation des performances de build

### Build
- APK debug fonctionnel
- Installation et lancement confirmés sur Android
- Package: `com.energysmart.energy_smart_systems`
- Version: 1.0.0 (versionCode: 1)
