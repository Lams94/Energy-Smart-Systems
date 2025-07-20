# 🎨 Guide d'Integration du Logo Energy Smart Systems

## 📍 Emplacements pour votre logo

### 1. Logo principal dans l'application
**Fichier à créer :** `assets/images/logo.png`
- **Taille recommandée :** 200x200px ou plus (format carré)
- **Format :** PNG avec transparence
- **Usage :** Écran de connexion, en-têtes, splash screen

### 2. Versions du logo
Créez ces variantes dans `assets/images/` :
- **`logo.png`** - Logo principal
- **`logo_white.png`** - Version blanche pour fonds sombres
- **`logo_horizontal.png`** - Version horizontale
- **`splash_logo.png`** - Pour écran de démarrage (512x512px)

### 3. Icône de l'application (Android)
Remplacez les fichiers dans :
```
android/app/src/main/res/
├── mipmap-mdpi/ic_launcher.png (48x48px)
├── mipmap-hdpi/ic_launcher.png (72x72px)
├── mipmap-xhdpi/ic_launcher.png (96x96px)
├── mipmap-xxhdpi/ic_launcher.png (144x144px)
└── mipmap-xxxhdpi/ic_launcher.png (192x192px)
```

## 🛠️ Comment intégrer le logo

### Dans le code Flutter
```dart
// Logo principal
Image.asset(
  'assets/images/logo.png',
  height: 80,
  width: 80,
)

// Logo avec charte ESS
Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: AppColors.surface, // #1A1A1A
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: AppColors.border), // #3ADF7C
  ),
  child: Image.asset('assets/images/logo.png'),
)
```

## 🎨 Charte graphique appliquée

### Couleurs ESS intégrées ✅
- **Fond principal :** `#0A0A0A` (noir profond)
- **Accent principal :** `#3ADF7C` (vert dynamique)
- **Secondaire :** `#00B8D9` (cyan technique)
- **Surface :** `#1A1A1A` (cartes et composants)
- **Texte principal :** `#FFFFFF` (blanc pur)
- **Texte secondaire :** `#B0B0B0` (gris clair)

### Typographie ESS ✅
- **Titres :** Poppins (bold/semibold)
- **Contenu :** Inter (normal/medium)
- **Données :** Roboto Mono

### Styles des composants ✅
- **Boutons :** `rounded-xl`, fond vert ou cyan
- **Cartes :** Fond `#1A1A1A`, bordures vertes
- **Inputs :** Fond gris foncé, bordures vertes

## 📱 Modifications apportées

### 1. Couleurs mises à jour
- ✅ `AppColors` avec palette ESS exacte
- ✅ Thème Material 3 adapté
- ✅ Gradients vert→cyan

### 2. Structure assets créée
- ✅ Dossier `assets/images/` 
- ✅ Dossier `assets/icons/`
- ✅ Configuration `pubspec.yaml`

### 3. Composants adaptés
- ✅ Cartes avec style ESS
- ✅ Boutons aux couleurs officielles
- ✅ Textes avec hiérarchie correcte

## 🚀 Prochaines étapes

1. **Placez votre logo** dans `assets/images/logo.png`
2. **Remplacez les icônes** dans `android/app/src/main/res/`
3. **Testez l'application** : `flutter build apk --debug`
4. **Installez** : `adb install build/app/outputs/flutter-apk/app-debug.apk`

## 📋 Checklist d'intégration

- [ ] Logo principal ajouté (`assets/images/logo.png`)
- [ ] Variantes du logo créées (blanc, horizontal)
- [ ] Icônes Android remplacées (tous les `ic_launcher.png`)
- [ ] Application recompilée et testée
- [ ] Charte graphique validée visuellement

## 💡 Conseils

### Format du logo
- **PNG avec transparence** pour flexibilité
- **Résolution élevée** (2x, 3x) pour écrans HD
- **Contraste élevé** pour visibilité sur fond sombre

### Intégration harmonieuse
- Utilisez les **couleurs ESS** dans votre logo si possible
- **Vert `#3ADF7C`** et **cyan `#00B8D9`** s'intègrent parfaitement
- Le **fond noir `#0A0A0A`** met en valeur les couleurs vives

---

**Votre application respecte maintenant la charte graphique ESS ! 🎉**

Ajoutez simplement votre logo et l'intégration sera complète.
