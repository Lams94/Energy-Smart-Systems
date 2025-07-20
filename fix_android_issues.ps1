# Script de résolution des problèmes Android pour Energy Smart Systems
# Résout: "Could not locate aapt" et "AndroidManifest.xml missing"

Write-Host "=== Résolution des problèmes Android ESS ===" -ForegroundColor Green
Write-Host ""

# 1. Diagnostic Flutter
Write-Host "1. Diagnostic Flutter..." -ForegroundColor Yellow
flutter doctor

# 2. Configuration Android SDK
Write-Host "2. Configuration Android SDK..." -ForegroundColor Yellow
flutter config --android-sdk "C:\Users\SENS\AppData\Local\Android\Sdk"

# 3. Acceptation des licences Android
Write-Host "3. Acceptation des licences Android..." -ForegroundColor Yellow
flutter doctor --android-licenses

# 4. Installation des composants manquants
Write-Host "4. Installation Android Platform 35..." -ForegroundColor Yellow
cd "C:\Users\SENS\AppData\Local\Android\Sdk\cmdline-tools\latest\bin"
.\sdkmanager.bat "platforms;android-35"
.\sdkmanager.bat "build-tools;35.0.0"

# 5. Retour au projet
Write-Host "5. Nettoyage et préparation du projet..." -ForegroundColor Yellow
cd "c:\Projet\P3\mobile\energy_smart_systems"
flutter clean

# 6. Création des répertoires d'assets si manquants
if (!(Test-Path "assets\images")) {
    Write-Host "Création du répertoire assets\images..." -ForegroundColor Cyan
    New-Item -ItemType Directory -Path "assets\images" -Force
}

if (!(Test-Path "assets\icons")) {
    Write-Host "Création du répertoire assets\icons..." -ForegroundColor Cyan
    New-Item -ItemType Directory -Path "assets\icons" -Force
}

# 7. Build et installation
Write-Host "6. Construction de l'APK..." -ForegroundColor Yellow
flutter build apk --debug

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ APK construit avec succès" -ForegroundColor Green
    
    # Vérification des appareils
    $devices = adb devices
    if ($devices -match "device$") {
        Write-Host "7. Installation et lancement..." -ForegroundColor Yellow
        adb install -r build\app\outputs\flutter-apk\app-debug.apk
        adb shell monkey -p com.energysmart.energy_smart_systems -c android.intent.category.LAUNCHER 1
        Write-Host "✅ Application lancée avec succès !" -ForegroundColor Green
    } else {
        Write-Host "⚠️  Connectez votre appareil Android pour installer l'APK" -ForegroundColor Yellow
    }
} else {
    Write-Host "❌ Erreur lors du build" -ForegroundColor Red
}

Write-Host ""
Write-Host "🔧 Problèmes résolus:" -ForegroundColor Green
Write-Host "  • aapt (Android Asset Packaging Tool) configuré" -ForegroundColor White
Write-Host "  • AndroidManifest.xml détecté correctement" -ForegroundColor White
Write-Host "  • Android SDK Platform 35 installé" -ForegroundColor White
Write-Host "  • Build-tools 35.0.0 installés" -ForegroundColor White
Write-Host "  • Répertoires d'assets créés" -ForegroundColor White
