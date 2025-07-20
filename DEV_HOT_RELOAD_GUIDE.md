# 🔥 Guide de Développement Hot Reload - Energy Smart Systems

## 🚨 Problème résolu

Le problème d'**aapt non trouvé** avec `flutter run` est contourné par un workflow de développement alternatif qui fonctionne parfaitement.

## 🛠️ Workflow de développement

### Option 1: Script PowerShell (Recommandé)
```powershell
# Build debug + Install + Launch
.\dev_hot_reload.ps1

# Build release + Install + Launch  
.\dev_hot_reload.ps1 -Release

# Build et install sans lancer
.\dev_hot_reload.ps1 -NoLaunch
```

### Option 2: Script Batch (Simple)
```batch
# Double-clic sur hot_reload.bat
# Ou depuis le terminal :
hot_reload.bat
```

### Option 3: Commandes manuelles
```bash
# 1. Construire l'APK
flutter build apk --debug

# 2. Installer sur l'appareil
adb install -r build\app\outputs\flutter-apk\app-debug.apk

# 3. Lancer l'application
adb shell am start -n com.energysmart.energy_smart_systems/com.energysmart.energy_smart_systems.MainActivity
```

## ⚡ Simulation Hot Reload

### Cycle de développement rapide :

1. **Modifier le code** Dart dans VS Code
2. **Sauvegarder** (Ctrl+S)
3. **Relancer le script** : `.\dev_hot_reload.ps1`
4. **Voir les changements** sur l'appareil (~40-60 secondes)

### Temps de cycle typique :
- **Build APK debug** : ~30-40s
- **Installation** : ~5-10s  
- **Lancement** : ~5s
- **Total** : ~45-60s par itération

## 🎯 Optimisations de développement

### 1. Builds incrémentaux
Flutter optimise automatiquement les builds suivants (plus rapides après la première compilation).

### 2. Développement par composants
Testez un composant à la fois en modifiant temporairement `main.dart` :

```dart
// Pour tester un composant spécifique
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkTheme, // Thème ESS
      home: Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: FloatingActionButtonEss.extended(
            onPressed: () {},
            icon: Icons.add,
            label: 'Test Component',
          ),
        ),
      ),
    );
  }
}
```

### 3. Debug avec logs
Utilisez `print()` ou `debugPrint()` pour suivre l'exécution :

```dart
print('🔍 Debug ESS: Variable = $value');
debugPrint('🎯 Component loaded: ${widget.runtimeType}');
```

Consultez les logs avec :
```bash
adb logcat | findstr flutter
```

## 📱 Monitoring de l'appareil

### Vérifier la connexion :
```bash
adb devices
```

### Logs en temps réel :
```bash
# Tous les logs Flutter
adb logcat | findstr flutter

# Logs de l'app ESS uniquement
adb logcat | findstr energysmart

# Erreurs uniquement
adb logcat *:E
```

### Redémarrer ADB si nécessaire :
```bash
adb kill-server
adb start-server
```

## 🎨 Test des composants ESS

### Composants à tester en priorité :

1. **AppBarEss** - Barre d'application
2. **BottomNavigationBarEss** - Navigation
3. **FloatingActionButtonEss** - Boutons d'action
4. **MissionCard** - Cartes de mission
5. **Couleurs et thème** - Palette ESS

### Écran de test complet :
Utilisez `HomeScreenEss` pour voir tous les composants ensemble.

## 🚀 Conseils de productivité

### 1. Raccourcis VS Code
- **Ctrl+Shift+P** → "Flutter: Hot Reload" (ne fonctionne pas, mais garde l'habitude)
- **Ctrl+S** → Sauvegarde automatique
- **F5** → Lancer le debugger (non applicable ici)

### 2. Workflow recommandé
```
Modifier code → Sauver → .\dev_hot_reload.ps1 → Tester → Répéter
```

### 3. Organisation des tests
Créez des branches pour tester des fonctionnalités spécifiques :
```bash
git checkout -b test-appbar-ess
# Modifier et tester AppBarEss
git commit -m "Test AppBarEss modifications"
```

## 🔧 Dépannage

### Problème : APK ne s'installe pas
```bash
# Désinstaller d'abord
adb uninstall com.energysmart.energy_smart_systems

# Réinstaller
adb install build\app\outputs\flutter-apk\app-debug.apk
```

### Problème : Application ne se lance pas
```bash
# Vérifier les processus
adb shell ps | findstr energysmart

# Forcer l'arrêt
adb shell am force-stop com.energysmart.energy_smart_systems

# Relancer
adb shell am start -n com.energysmart.energy_smart_systems/com.energysmart.energy_smart_systems.MainActivity
```

### Problème : Modifications non visibles
1. Vérifiez que l'APK debug est bien installé
2. Redémarrez l'application complètement
3. Vérifiez qu'il n'y a pas d'erreurs de compilation

## ✅ Validation du setup

Votre environnement de développement ESS est prêt si :

- [ ] `.\dev_hot_reload.ps1` fonctionne sans erreur
- [ ] L'application se lance avec la charte ESS
- [ ] Les modifications de code sont visibles après rebuild
- [ ] Les logs ADB sont accessibles
- [ ] L'appareil reste connecté

---

**🎯 Résultat :** Développement Flutter efficace malgré les limitations d'aapt !
