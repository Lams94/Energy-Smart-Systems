# 🔧 RÉSOLUTION - ERREUR D'INSTALLATION APK

## ❌ Problème rencontré

```
INSTALL_FAILED_USER_RESTRICTED: Install canceled by user
```

## 🛠️ Solutions à essayer

### 1. Accepter l'installation sur l'appareil Android
- **Regardez l'écran de votre appareil Android**
- **Popup d'installation** : Appuyez sur "Installer" ou "OK"
- **Dialogue de sécurité** : Autorisez l'installation depuis cette source

### 2. Activer "Sources inconnues" (si nécessaire)
Sur votre appareil Android :
1. **Paramètres** → **Sécurité** → **Sources inconnues** ✅
2. Ou **Paramètres** → **Confidentialité** → **Installer des apps inconnues** ✅
3. Autoriser **ADB/USB debugging** pour installer des apps

### 3. Vérifier le débogage USB
1. **Paramètres** → **Options de développement**
2. **Débogage USB** ✅ (activé)
3. **Installer via USB** ✅ (activé si disponible)
4. **Vérification des apps via USB** ❌ (désactivé)

### 4. Méthode alternative - Installation manuelle

Si l'installation ADB continue d'échouer :

```powershell
# 1. Copier l'APK sur l'appareil
adb push build\app\outputs\flutter-apk\app-debug.apk /sdcard/Download/ess-app.apk

# 2. Installer depuis l'appareil
# Aller dans Explorateur de fichiers → Téléchargements
# Toucher ess-app.apk et installer manuellement
```

### 5. Méthode push et installation

```powershell
# Script de push + installation manuelle
adb push build\app\outputs\flutter-apk\app-debug.apk /sdcard/Download/energy_smart_systems.apk
adb shell am start -a android.intent.action.VIEW -d file:///sdcard/Download/energy_smart_systems.apk -t application/vnd.android.package-archive
```

## 🔄 Script mis à jour

Voici le script `install_apk.bat` pour gérer ces cas :

```batch
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
    pause
) else (
    echo ✅ Application installée avec succès !
    echo 🚀 Lancement de l'application...
    adb shell am start -n com.energysmart.energy_smart_systems/com.energysmart.energy_smart_systems.MainActivity
)

pause
```

## 💡 Action immédiate

**Essayez maintenant :**

1. **Regardez votre appareil Android** - Y a-t-il un popup d'installation ?
2. **Acceptez l'installation** si demandé
3. Si ça ne marche pas, utilisez la méthode push :

```bash
adb push build\app\outputs\flutter-apk\app-debug.apk /sdcard/Download/ess-app.apk
```

Puis installez manuellement depuis l'explorateur de fichiers Android.

---

**🎯 L'APK avec logo ESS est prêt - il faut juste réussir l'installation !**
