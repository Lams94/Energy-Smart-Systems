# Script de build Energy Smart Systems avec couleurs ESS
Write-Host "=== Energy Smart Systems - Build ESS ===" -ForegroundColor Green
Write-Host "Application de base avec couleurs ESS appliquées" -ForegroundColor Cyan
Write-Host ""

# 1. Build de l'APK
Write-Host "1. Construction de l'APK..." -ForegroundColor Yellow
flutter build apk --debug

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Erreur lors du build" -ForegroundColor Red
    exit 1
}

Write-Host "✅ APK construit avec succès" -ForegroundColor Green

# 2. Vérification des appareils
Write-Host "2. Vérification des appareils Android..." -ForegroundColor Yellow
$devices = adb devices
Write-Host $devices

if ($devices -match "device$") {
    Write-Host "✅ Appareil Android détecté" -ForegroundColor Green
    
    # 3. Installation
    Write-Host "3. Installation en cours..." -ForegroundColor Yellow
    adb install -r build\app\outputs\flutter-apk\app-debug.apk
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ APK installé avec succès" -ForegroundColor Green
        
        # 4. Lancement
        Write-Host "4. Lancement de l'application..." -ForegroundColor Yellow
        adb shell monkey -p com.energysmart.energy_smart_systems -c android.intent.category.LAUNCHER 1
        
        Write-Host "✅ Application lancée !" -ForegroundColor Green
    } else {
        Write-Host "❌ Erreur lors de l'installation" -ForegroundColor Red
    }
} else {
    Write-Host "⚠️  Aucun appareil Android connecté" -ForegroundColor Yellow
    Write-Host "📱 Connectez votre appareil Android et activez le débogage USB" -ForegroundColor Cyan
    Write-Host "📄 APK disponible : build\app\outputs\flutter-apk\app-debug.apk" -ForegroundColor White
}

Write-Host ""
Write-Host "🎨 Couleurs ESS appliquées:" -ForegroundColor Green
Write-Host "  • Fond principal: #0A0A0A (noir ESS)" -ForegroundColor White
Write-Host "  • Accent principal: #3ADF7C (vert pro ESS)" -ForegroundColor Green
Write-Host "  • Accent secondaire: #00B8D9 (cyan technique ESS)" -ForegroundColor Cyan
Write-Host "  • Surface: #1A1A1A (composants ESS)" -ForegroundColor White
Write-Host "  • Texte principal: #FFFFFF (blanc)" -ForegroundColor White
Write-Host "  • Texte secondaire: #B0B0B0 (gris ESS)" -ForegroundColor Gray
