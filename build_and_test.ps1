# Script de build et test pour Energy Smart Systems
Write-Host "=== Build & Test ESS ===" -ForegroundColor Green

# 1. Build de l'APK
Write-Host "1. Construction de l'APK..." -ForegroundColor Yellow
flutter build apk --debug

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Erreur lors du build" -ForegroundColor Red
    exit 1
}

Write-Host "✅ APK construit avec succès" -ForegroundColor Green

# 2. Installation sur l'appareil
Write-Host "2. Installation sur l'appareil Android..." -ForegroundColor Yellow
adb install -r build\app\outputs\flutter-apk\app-debug.apk

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Erreur lors de l'installation" -ForegroundColor Red
    exit 1
}

Write-Host "✅ APK installé avec succès" -ForegroundColor Green

# 3. Lancement de l'application
Write-Host "3. Lancement de l'application..." -ForegroundColor Yellow
adb shell monkey -p com.energysmart.energy_smart_systems -c android.intent.category.LAUNCHER 1

Write-Host "✅ Application lancée !" -ForegroundColor Green
Write-Host ""
Write-Host "🎯 Testez maintenant:" -ForegroundColor Cyan
Write-Host "  • Splash screen avec logo ESS animé" -ForegroundColor White
Write-Host "  • Transition fluide vers l'écran principal" -ForegroundColor White
Write-Host "  • Affichage correct des couleurs ESS" -ForegroundColor White
Write-Host ""
Write-Host "📱 L'application devrait être visible sur votre appareil Android" -ForegroundColor Green
