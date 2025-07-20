# Scripts Energy Smart Systems

Ce dossier contient les scripts utilitaires pour le projet Energy Smart Systems.

## Scripts disponibles

### 1. `generate_apk.ps1` - Génération d'APK automatisée

**Description :** Script PowerShell pour générer automatiquement l'APK de l'application avec vérifications préalables.

**Utilisation :**
```powershell
# Génération APK debug (par défaut)
.\generate_apk.ps1

# Génération APK release
.\generate_apk.ps1 -BuildType release

# Avec nettoyage préalable
.\generate_apk.ps1 -CleanFirst

# Ignorer la vérification d'espace disque
.\generate_apk.ps1 -SkipSpaceCheck
```

**Fonctionnalités :**
- ✅ Vérification de l'espace disque (minimum 5GB)
- ✅ Vérification de Flutter
- ✅ Nettoyage optionnel du projet
- ✅ Récupération des dépendances
- ✅ Analyse du code
- ✅ Génération APK (debug/release)
- ✅ Copie automatique sur le bureau
- ✅ Informations détaillées du build

### 2. `fix_withOpacity.ps1` - Correction des warnings dépréciés

**Description :** Script PowerShell pour corriger automatiquement les usages dépréciés de `withOpacity`.

**Utilisation :**
```powershell
.\fix_withOpacity.ps1
```

**Fonctionnalités :**
- ✅ Correction automatique de `withOpacity` → `withValues(alpha: x)`
- ✅ Traitement récursif de tous les fichiers Dart
- ✅ Sauvegarde des modifications
- ✅ Rapport des corrections effectuées

### 3. `fix_withOpacity.sh` - Version Unix/Linux

**Description :** Version shell du script de correction pour environnements Unix/Linux.

**Utilisation :**
```bash
chmod +x fix_withOpacity.sh
./fix_withOpacity.sh
```

## Prérequis

### Pour Windows (PowerShell)
- Windows 10/11
- PowerShell 5.1 ou supérieur
- Flutter SDK installé et dans le PATH
- Android SDK configuré

### Pour Unix/Linux (Bash)
- bash
- sed
- find
- Flutter SDK installé et dans le PATH

## Instructions d'utilisation

### 1. Première utilisation

```powershell
# Naviguer vers le répertoire des scripts
cd c:\Projet\P3\mobile\energy_smart_systems\scripts

# Autoriser l'exécution des scripts PowerShell (si nécessaire)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Exécuter le script de génération APK
.\generate_apk.ps1
```

### 2. Résolution des problèmes courants

#### Espace disque insuffisant
```powershell
# Vérifier l'espace disque
Get-WmiObject -Class Win32_LogicalDisk -Filter "DeviceID='C:'" | Select-Object Size,FreeSpace

# Nettoyer Flutter/Gradle
flutter clean
Remove-Item -Recurse -Force "$env:USERPROFILE\.gradle\caches"
```

#### Erreurs de compilation Android
```powershell
# Nettoyer et reconstruire
flutter clean
flutter pub get
flutter build apk --debug
```

### 3. Génération pour production

```powershell
# APK optimisé pour production
.\generate_apk.ps1 -BuildType release -CleanFirst
```

## Résultats attendus

### APK Debug
- **Taille :** ~50-100 MB
- **Localisation :** `build/app/outputs/flutter-apk/app-debug.apk`
- **Usage :** Tests et développement

### APK Release
- **Taille :** ~30-60 MB (optimisé)
- **Localisation :** `build/app/outputs/flutter-apk/app-release.apk`
- **Usage :** Production et distribution

## Dépannage

### Erreur "Flutter non trouvé"
```powershell
# Vérifier Flutter
flutter --version

# Réinstaller Flutter si nécessaire
# Suivre https://docs.flutter.dev/get-started/install/windows
```

### Erreur "Android SDK manquant"
```powershell
# Vérifier Android SDK
flutter doctor

# Installer via Android Studio
# Tools > SDK Manager > SDK Platforms
```

### Erreur "Espace disque insuffisant"
```powershell
# Libérer de l'espace
cleanmgr /sagerun:1

# Vérifier l'espace libéré
Get-WmiObject -Class Win32_LogicalDisk -Filter "DeviceID='C:'"
```

## Logs et débogage

Les scripts génèrent des logs détaillés en console avec codes couleur :
- 🟢 **Vert** : Succès
- 🟡 **Jaune** : Information/Avertissement
- 🔴 **Rouge** : Erreur
- 🔵 **Bleu** : Information générale
- 🟦 **Cyan** : Détails techniques

## Support

Pour toute question ou problème :
1. Vérifier les logs d'erreur
2. Consulter `docs/guide_generation_apk.md`
3. Exécuter `flutter doctor -v` pour diagnostic complet
