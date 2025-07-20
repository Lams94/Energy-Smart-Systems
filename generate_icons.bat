@echo off
echo 🎨 Génération des icônes ESS pour Android
echo =========================================

rem Vérifier que le logo source existe
if not exist "assets\images\logo.png" (
    echo ❌ Logo source non trouvé: assets\images\logo.png
    echo 💡 Placez votre logo ESS dans assets/images/logo.png
    pause
    exit /b 1
)

echo 🔄 Copie du logo vers les répertoires d'icônes...

rem Créer les répertoires s'ils n'existent pas et copier le logo
copy "assets\images\logo.png" "android\app\src\main\res\mipmap-mdpi\ic_launcher.png"
copy "assets\images\logo.png" "android\app\src\main\res\mipmap-hdpi\ic_launcher.png"
copy "assets\images\logo.png" "android\app\src\main\res\mipmap-xhdpi\ic_launcher.png"
copy "assets\images\logo.png" "android\app\src\main\res\mipmap-xxhdpi\ic_launcher.png"
copy "assets\images\logo.png" "android\app\src\main\res\mipmap-xxxhdpi\ic_launcher.png"

echo ✅ Icônes générées avec succès !
echo 💡 Rebuild et réinstallez l'APK pour voir les changements
echo.
pause
