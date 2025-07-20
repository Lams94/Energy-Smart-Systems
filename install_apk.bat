@echo off
echo 🚀 Installation APK Energy Smart Systems
echo =======================================

echo 📱 Tentative d'installation directe...
adb install -r build\app\outputs\flutter-apk\app-debug.apk

if errorlevel 1 (
    echo.
    echo ⚠️ Installation directe échouée
    echo 📲 Méthode alternative - Push vers l'appareil...
    
    adb push build\app\outputs\flutter-apk\app-debug.apk /sdcard/Download/ess-app.apk
    
    if errorlevel 1 (
        echo ❌ Impossible de copier vers l'appareil
        echo 💡 Vérifiez que l'appareil est connecté et déverrouillé
        pause
        exit /b 1
    )
    
    echo ✅ APK copié vers /sdcard/Download/ess-app.apk
    echo.
    echo 📱 Instructions pour installation manuelle :
    echo 1. Sur votre appareil Android, ouvrez l'Explorateur de fichiers
    echo 2. Allez dans Téléchargements
    echo 3. Touchez ess-app.apk
    echo 4. Acceptez l'installation
    echo.
    echo 🔄 Tentative d'ouverture automatique du gestionnaire de fichiers...
    adb shell am start -a android.intent.action.VIEW -d file:///sdcard/Download/ess-app.apk -t application/vnd.android.package-archive
    echo.
    pause
) else (
    echo ✅ Application installée avec succès !
    echo 🚀 Lancement de l'application...
    adb shell am start -n com.energysmart.energy_smart_systems/com.energysmart.energy_smart_systems.MainActivity
    echo ✅ Application Energy Smart Systems lancée !
)

pause
