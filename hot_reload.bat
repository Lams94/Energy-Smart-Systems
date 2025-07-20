@echo off
echo 🚀 Hot Reload Manuel - Energy Smart Systems
echo ==========================================

rem Vérifier qu'on est dans le bon répertoire
if not exist "pubspec.yaml" (
    echo ❌ Erreur: pubspec.yaml non trouvé. Exécutez ce script depuis la racine du projet Flutter.
    pause
    exit /b 1
)

echo 📱 Construction de l'APK debug...
flutter build apk --debug
if errorlevel 1 (
    echo ❌ Erreur lors de la construction
    pause
    exit /b 1
)

echo ✅ APK construit avec succès !

echo 📲 Installation sur l'appareil...
adb install -r build\app\outputs\flutter-apk\app-debug.apk
if errorlevel 1 (
    echo ❌ Erreur lors de l'installation
    pause
    exit /b 1
)

echo ✅ Application installée !

echo 🚀 Lancement de l'application...
adb shell am start -n com.energysmart.energy_smart_systems/com.energysmart.energy_smart_systems.MainActivity

echo.
echo ✅ Application Energy Smart Systems lancée !
echo 💡 Modifiez votre code et relancez ce script pour voir les changements
echo.
pause
