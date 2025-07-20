# Guide d'intégration Energy Smart Systems (ESS) - Flutter

## 🎨 Charte graphique implémentée

### Palette de couleurs ESS
- **Fond principal** : `#0A0A0A` (noir profond)
- **Surfaces** : `#1A1A1A` (gris foncé)
- **Accent principal** : `#3ADF7C` (vert dynamique ESS)
- **Accent secondaire** : `#00B8D9` (cyan technique)
- **Texte principal** : `#FFFFFF` (blanc pur)
- **Texte secondaire** : `#B0B0B0` (gris clair)
- **Bordures** : `#3ADF7C` (vert avec transparence)

### Typographie ESS
- **Titre/Headers** : Poppins (Bold/SemiBold)
- **Corps de texte** : Inter (Regular/Medium)
- **Letterspacing** optimisé pour la lisibilité

## 📱 Composants créés/adaptés

### 1. AppBarEss (`app_bar_ess.dart`)
- Fond noir ESS `#0A0A0A`
- Logo ESS avec gradient vert-cyan
- Boutons d'action avec style unifié
- Bordure inférieure verte subtile

### 2. BottomNavigationBarEss (`bottom_navigation_bar_ess.dart`)
- Navigation fluide avec animations
- Items avec gradient de sélection
- Badges de notification intégrés
- Style "rounded-xl" selon charte

### 3. FloatingActionButtonEss (`floating_action_button_ess.dart`)
- Gradient vert-cyan caractéristique
- Animations d'interaction avancées
- Variantes étendues et icônes
- Ombres multicouches pour profondeur

### 4. MissionCard (`mission_card.dart`)
- Déjà adapté aux couleurs ESS
- Bordures vertes `#3ADF7C`
- Badges de statut colorés
- Typographie Poppins/Inter

### 5. Écran d'exemple (`home_screen_ess.dart`)
- Intégration complète de tous les composants
- Dashboard avec statistiques
- Navigation entre sections
- Démonstration des interactions

## 🛠️ Fichiers de configuration

### Couleurs (`app_colors.dart`)
```dart
// Couleurs officielles Energy Smart Systems
static const Color background = Color(0xFF0A0A0A);
static const Color surface = Color(0xFF1A1A1A);
static const Color primary = Color(0xFF3ADF7C);
static const Color secondary = Color(0xFF00B8D9);
// ... autres couleurs
```

### Thème (`app_theme.dart`)
- Configuration Material 3 avec couleurs ESS
- Intégration Google Fonts (Poppins/Inter)
- Thème sombre optimisé
- Composants stylisés uniformément

### Assets (`pubspec.yaml`)
```yaml
flutter:
  assets:
    - assets/images/
    - assets/icons/
```

## 🖼️ Intégration du logo

### Étapes pour ajouter le logo ESS :

1. **Placer les fichiers logo** dans `assets/images/` :
   ```
   assets/images/
   ├── logo_ess.png          # Logo principal
   ├── logo_ess_white.png    # Version blanche
   ├── logo_ess_icon.png     # Icône seule
   └── logo_ess_splash.png   # Version splash screen
   ```

2. **Remplacer le placeholder** dans `AppBarEss._buildLogo()` :
   ```dart
   Widget _buildLogo() {
     return Container(
       width: 40,
       height: 40,
       child: Image.asset(
         'assets/images/logo_ess_white.png',
         fit: BoxFit.contain,
       ),
     );
   }
   ```

3. **Ajouter splash screen** ESS dans `android/app/src/main/res/drawable/launch_background.xml`

## 🔄 Utilisation des composants

### AppBar ESS
```dart
AppBarEss(
  title: 'Mon Titre',
  showLogo: true,
  actions: [
    AppBarEssActions.notificationButton(
      onPressed: () => {},
      badgeCount: 3,
    ),
  ],
)
```

### Navigation Bottom ESS
```dart
BottomNavigationBarEss(
  currentIndex: _currentIndex,
  onTap: (index) => setState(() => _currentIndex = index),
  items: const [
    BottomNavEssItems.dashboard,
    BottomNavEssItems.missions,
    BottomNavEssItems.reports,
  ],
)
```

### FAB ESS
```dart
// Version étendue
FabEssPresets.addMission(
  onPressed: () => {},
  isLoading: false,
)

// Version icône simple
FloatingActionButtonEss.icon(
  onPressed: () => {},
  icon: Icons.qr_code_scanner,
)
```

## ✅ Validation de l'intégration

### Points de contrôle :
- [ ] Couleurs ESS appliquées partout
- [ ] Typographie Poppins/Inter utilisée
- [ ] Logo ESS intégré (après placement fichier)
- [ ] Animations fluides fonctionnelles
- [ ] Style "rounded-xl" respecté
- [ ] Gradients vert-cyan présents
- [ ] Badges et notifications stylés

### Test sur l'écran d'exemple :
1. Lancer `HomeScreenEss` pour voir l'intégration complète
2. Naviguer entre les onglets
3. Tester les interactions (FAB, notifications, menu)
4. Vérifier la cohérence visuelle

## 🚀 Prochaines étapes

1. **Placer le logo ESS** dans le dossier assets/images/
2. **Adapter d'autres écrans** avec les composants ESS
3. **Implémenter splash screen** avec logo ESS
4. **Tester sur différentes tailles** d'écran
5. **Optimiser les animations** si nécessaire

## 💡 Conseils d'usage

- Utilisez toujours les composants ESS pour la cohérence
- Respectez la palette de couleurs officielle
- Préférez les gradients pour les éléments importants
- Maintenez les animations fluides (200ms standard)
- Testez en mode sombre uniquement (thème ESS)

---

**Energy Smart Systems** - Interface mobile optimisée pour l'efficacité énergétique
Version Flutter 3.32.6 | Material 3 | Charte ESS 2024
