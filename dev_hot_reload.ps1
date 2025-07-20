# Script de développement Flutter avec "Hot Reload" manuel
# Pour contourner les problèmes d'aapt avec flutter run

param(
    [switch]$Release,
    [switch]$NoLaunch
)

Write-Host "🚀 Script de développement Energy Smart Systems" -ForegroundColor Green
Write-Host "===============================================" -ForegroundColor Green

# Vérifier qu'on est dans le bon répertoire
if (-not (Test-Path "pubspec.yaml")) {
    Write-Host "❌ Erreur: pubspec.yaml non trouvé. Exécutez ce script depuis la racine du projet Flutter." -ForegroundColor Red
    exit 1
}

# Déterminer le type de build
$buildType = if ($Release) { "--release" } else { "--debug" }
$apkName = if ($Release) { "app-release.apk" } else { "app-debug.apk" }

Write-Host "📱 Construction de l'APK ($buildType)..." -ForegroundColor Yellow
$buildStart = Get-Date

try {
    # Nettoyer d'abord pour forcer un rebuild complet
    Write-Host "🧹 Nettoyage des builds précédents..." -ForegroundColor Yellow
    flutter clean
    
    # Récupérer les dépendances
    Write-Host "📦 Récupération des dépendances..." -ForegroundColor Yellow
    flutter pub get
    
    # Construire l'APK
    if ($Release) {
        flutter build apk --release
    } else {
        flutter build apk --debug
    }
    
    $buildEnd = Get-Date
    $buildTime = ($buildEnd - $buildStart).TotalSeconds
    Write-Host "✅ APK construit en $([math]::Round($buildTime, 1))s" -ForegroundColor Green
    
} catch {
    Write-Host "❌ Erreur lors de la construction: $_" -ForegroundColor Red
    exit 1
}

# Vérifier que l'appareil est connecté
Write-Host "📱 Vérification de la connexion ADB..." -ForegroundColor Yellow
$devices = adb devices
if ($devices -match "device$") {
    Write-Host "✅ Appareil Android détecté" -ForegroundColor Green
} else {
    Write-Host "❌ Aucun appareil Android connecté. Connectez votre appareil et activez le débogage USB." -ForegroundColor Red
    exit 1
}

# Installer l'APK
Write-Host "📲 Installation de l'APK..." -ForegroundColor Yellow
$installStart = Get-Date

try {
    # Désinstaller l'ancienne version d'abord
    Write-Host "🗑️ Suppression de l'ancienne version..." -ForegroundColor Yellow
    adb uninstall com.energysmart.energy_smart_systems 2>$null
    
    $installResult = adb install "build\app\outputs\flutter-apk\$apkName"
    if ($installResult -match "Success") {
        $installEnd = Get-Date
        $installTime = ($installEnd - $installStart).TotalSeconds
        Write-Host "✅ Application installée en $([math]::Round($installTime, 1))s" -ForegroundColor Green
    } else {
        Write-Host "❌ Erreur lors de l'installation: $installResult" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "❌ Erreur lors de l'installation: $_" -ForegroundColor Red
    exit 1
}

# Lancer l'application
if (-not $NoLaunch) {
    Write-Host "🚀 Lancement de l'application..." -ForegroundColor Yellow
    try {
        adb shell am start -n com.energysmart.energy_smart_systems/com.energysmart.energy_smart_systems.MainActivity
        Write-Host "✅ Application lancée avec succès !" -ForegroundColor Green
    } catch {
        Write-Host "❌ Erreur lors du lancement: $_" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "🎯 Développement ESS - Prêt !" -ForegroundColor Green
Write-Host "💡 Conseils:" -ForegroundColor Cyan
Write-Host "   • Modifiez votre code Dart" -ForegroundColor White
Write-Host "   • Relancez ce script pour voir les changements" -ForegroundColor White
Write-Host "   • Utilisez -Release pour une version optimisée" -ForegroundColor White
Write-Host ""
Write-Host "🔄 Commandes rapides:" -ForegroundColor Cyan
Write-Host "   .\dev_hot_reload.ps1          # Build debug + install + launch" -ForegroundColor White
Write-Host "   .\dev_hot_reload.ps1 -Release # Build release + install + launch" -ForegroundColor White
Write-Host ""
