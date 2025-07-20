# Script de génération d'APK - Energy Smart Systems
# Exécuter après avoir libéré l'espace disque

param(
    [string]$BuildType = "debug",
    [switch]$CleanFirst = $false,
    [switch]$SkipSpaceCheck = $false
)

Write-Host "=== Energy Smart Systems - Génération APK ===" -ForegroundColor Green

# Vérification de l'espace disque
if (-not $SkipSpaceCheck) {
    Write-Host "Vérification de l'espace disque..." -ForegroundColor Yellow
    $disk = Get-WmiObject -Class Win32_LogicalDisk -Filter "DeviceID='C:'"
    $freeSpaceGB = [math]::Round($disk.FreeSpace / 1GB, 2)
    
    Write-Host "Espace libre sur C: : $freeSpaceGB GB" -ForegroundColor Cyan
    
    if ($freeSpaceGB -lt 5) {
        Write-Host "ERREUR: Espace disque insuffisant ($freeSpaceGB GB)" -ForegroundColor Red
        Write-Host "Minimum requis : 5 GB" -ForegroundColor Red
        Write-Host "Libérez de l'espace et relancez le script." -ForegroundColor Red
        exit 1
    }
    
    Write-Host "✅ Espace disque OK ($freeSpaceGB GB)" -ForegroundColor Green
}

# Navigation vers le répertoire du projet
$projectPath = "c:\Projet\P3\mobile\energy_smart_systems"
Write-Host "Navigation vers : $projectPath" -ForegroundColor Yellow

if (-not (Test-Path $projectPath)) {
    Write-Host "ERREUR: Répertoire projet non trouvé : $projectPath" -ForegroundColor Red
    exit 1
}

Set-Location $projectPath

# Vérification que Flutter est installé
Write-Host "Vérification de Flutter..." -ForegroundColor Yellow
try {
    flutter --version | Out-Null
    Write-Host "✅ Flutter détecté" -ForegroundColor Green
} catch {
    Write-Host "ERREUR: Flutter non trouvé dans PATH" -ForegroundColor Red
    exit 1
}

# Nettoyage si demandé
if ($CleanFirst) {
    Write-Host "Nettoyage du projet..." -ForegroundColor Yellow
    flutter clean
    Write-Host "✅ Nettoyage terminé" -ForegroundColor Green
}

# Récupération des dépendances
Write-Host "Récupération des dépendances..." -ForegroundColor Yellow
flutter pub get

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERREUR: Échec de pub get" -ForegroundColor Red
    exit 1
}
Write-Host "✅ Dépendances récupérées" -ForegroundColor Green

# Analyse du code
Write-Host "Analyse du code..." -ForegroundColor Yellow
flutter analyze

if ($LASTEXITCODE -ne 0) {
    Write-Host "ATTENTION: Analyse avec warnings/erreurs" -ForegroundColor Yellow
    $continue = Read-Host "Continuer malgré les warnings ? (y/N)"
    if ($continue -ne "y" -and $continue -ne "Y") {
        Write-Host "Génération annulée" -ForegroundColor Red
        exit 1
    }
}
Write-Host "✅ Analyse terminée" -ForegroundColor Green

# Génération de l'APK
Write-Host "Génération de l'APK ($BuildType)..." -ForegroundColor Yellow
$startTime = Get-Date

if ($BuildType -eq "release") {
    flutter build apk --release
} else {
    flutter build apk --debug
}

$endTime = Get-Date
$duration = $endTime - $startTime

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERREUR: Échec de la génération APK" -ForegroundColor Red
    exit 1
}

# Vérification du fichier APK généré
$apkPath = "build\app\outputs\flutter-apk\app-$BuildType.apk"
if (Test-Path $apkPath) {
    $apkSize = [math]::Round((Get-Item $apkPath).Length / 1MB, 2)
    Write-Host "✅ APK généré avec succès !" -ForegroundColor Green
    Write-Host "Fichier : $apkPath" -ForegroundColor Cyan
    Write-Host "Taille : $apkSize MB" -ForegroundColor Cyan
    Write-Host "Durée : $($duration.TotalMinutes.ToString('F1')) minutes" -ForegroundColor Cyan
    
    # Copie vers le bureau pour faciliter le test
    $desktopPath = [Environment]::GetFolderPath("Desktop")
    $apkDestination = "$desktopPath\EnergySmartSystems-$BuildType-$(Get-Date -Format 'yyyyMMdd-HHmm').apk"
    
    try {
        Copy-Item $apkPath $apkDestination
        Write-Host "✅ APK copié sur le bureau : $apkDestination" -ForegroundColor Green
    } catch {
        Write-Host "⚠️ Impossible de copier sur le bureau" -ForegroundColor Yellow
    }
    
} else {
    Write-Host "ERREUR: Fichier APK non trouvé : $apkPath" -ForegroundColor Red
    exit 1
}

Write-Host "`n=== Génération terminée avec succès ===" -ForegroundColor Green
Write-Host "Vous pouvez maintenant installer l'APK sur un appareil Android." -ForegroundColor Cyan
Write-Host "Commande ADB : adb install $apkPath" -ForegroundColor Cyan

# Affichage des informations du projet
Write-Host "`n=== Informations du projet ===" -ForegroundColor Blue
Write-Host "Nom : Energy Smart Systems" -ForegroundColor White
Write-Host "Version : 1.0.0" -ForegroundColor White
Write-Host "Package : com.energysmart.energy_smart_systems" -ForegroundColor White
Write-Host "Build : $BuildType" -ForegroundColor White
Write-Host "Date : $(Get-Date -Format 'dd/MM/yyyy HH:mm')" -ForegroundColor White
