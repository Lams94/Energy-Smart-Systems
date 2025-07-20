# Script de développement Flutter - Energy Smart Systems
# Contournement du problème aapt pour le hot reload

Write-Host "=== Energy Smart Systems - Mode Développement ===" -ForegroundColor Green

# Variables
$deviceId = "6dadb7f9"
$appPackage = "com.energysmart.energy_smart_systems"
$mainActivity = "$appPackage.MainActivity"

Write-Host "Dispositif cible: $deviceId" -ForegroundColor Cyan

# Fonction pour construire et installer l'APK
function BuildAndInstall {
    Write-Host "`n🔨 Construction de l'APK..." -ForegroundColor Yellow
    flutter build apk --debug
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ APK construit avec succès" -ForegroundColor Green
        
        Write-Host "`n📱 Installation sur l'appareil..." -ForegroundColor Yellow
        adb install -r build\app\outputs\flutter-apk\app-debug.apk
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Installation réussie" -ForegroundColor Green
            
            Write-Host "`n🚀 Lancement de l'application..." -ForegroundColor Yellow
            adb shell am start -n "$appPackage/$mainActivity"
            
            Write-Host "✅ Application lancée" -ForegroundColor Green
        } else {
            Write-Host "❌ Erreur lors de l'installation" -ForegroundColor Red
            return $false
        }
    } else {
        Write-Host "❌ Erreur lors de la construction" -ForegroundColor Red
        return $false
    }
    return $true
}

# Menu principal
do {
    Write-Host "`n=== OPTIONS DISPONIBLES ===" -ForegroundColor Blue
    Write-Host "1. Construire et installer l'APK" -ForegroundColor White
    Write-Host "2. Installer l'APK existant" -ForegroundColor White
    Write-Host "3. Lancer l'application" -ForegroundColor White
    Write-Host "4. Vérifier les dispositifs" -ForegroundColor White
    Write-Host "5. Nettoyer le projet" -ForegroundColor White
    Write-Host "6. Quitter" -ForegroundColor White
    
    $choice = Read-Host "`nChoisissez une option (1-6)"
    
    switch ($choice) {
        "1" {
            BuildAndInstall
        }
        "2" {
            Write-Host "`n📱 Installation de l'APK existant..." -ForegroundColor Yellow
            adb install -r build\app\outputs\flutter-apk\app-debug.apk
            if ($LASTEXITCODE -eq 0) {
                Write-Host "✅ Installation réussie" -ForegroundColor Green
            }
        }
        "3" {
            Write-Host "`n🚀 Lancement de l'application..." -ForegroundColor Yellow
            adb shell am start -n "$appPackage/$mainActivity"
            Write-Host "✅ Application lancée" -ForegroundColor Green
        }
        "4" {
            Write-Host "`n📱 Dispositifs connectés:" -ForegroundColor Yellow
            flutter devices
        }
        "5" {
            Write-Host "`n🧹 Nettoyage du projet..." -ForegroundColor Yellow
            flutter clean
            flutter pub get
            Write-Host "✅ Nettoyage terminé" -ForegroundColor Green
        }
        "6" {
            Write-Host "`n👋 Au revoir!" -ForegroundColor Green
            break
        }
        default {
            Write-Host "❌ Option invalide" -ForegroundColor Red
        }
    }
} while ($choice -ne "6")

Write-Host "`n=== NOTES DE DÉVELOPPEMENT ===" -ForegroundColor Blue
Write-Host "• L'application fonctionne correctement sur votre appareil" -ForegroundColor White
Write-Host "• Le problème 'aapt' n'affecte que l'installation automatique" -ForegroundColor White
Write-Host "• Utilisez ce script pour développer efficacement" -ForegroundColor White
Write-Host "• L'APK peut être installé et lancé manuellement" -ForegroundColor White
