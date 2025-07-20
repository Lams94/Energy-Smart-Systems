import 'package:flutter/material.dart';

/// Couleurs officielles Energy Smart Systems (ESS)
/// Charte graphique professionnelle avec thème sombre
class AppColors {
  AppColors._();

  // === COULEURS PRINCIPALES ESS ===

  /// Couleur de fond principale (background) - #0A0A0A (bleu nuit / noir profond)
  static const Color primaryDark = Color(0xFF0A0A0A);
  static const Color background = Color(0xFF0A0A0A);

  /// Couleur d'accent principal - #3ADF7C (vert pro dynamique)
  static const Color primary = Color(0xFF3ADF7C);
  static const Color accentGreenLight = Color(0xFF3ADF7C);

  /// Couleur secondaire - #00B8D9 (cyan technique lumineux)
  static const Color secondary = Color(0xFF00B8D9);
  static const Color accentTurquoise = Color(0xFF00B8D9);

  /// Surface composant / fond carte - #1A1A1A
  static const Color surface = Color(0xFF1A1A1A);
  static const Color cardBackground = Color(0xFF1A1A1A);

  // === COULEURS DE TEXTE ===

  /// Texte principal - #FFFFFF (blanc pur)
  static const Color textPrimary = Color(0xFFFFFFFF);

  /// Texte secondaire / atténué - #B0B0B0 (gris clair)
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textMuted = Color(0xFFB0B0B0);

  // === COULEURS DE STATUT ===

  /// Alerte / Erreur - #FF4D4F
  static const Color error = Color(0xFFFF4D4F);

  /// Succès / Validation - #4ADE80
  static const Color success = Color(0xFF4ADE80);

  /// Avertissement - Orange
  static const Color warning = Color(0xFFFFB020);

  /// Information - Cyan
  static const Color info = Color(0xFF00B8D9);

  // === COULEURS SPÉCIALISÉES ===

  /// Couleur de fond pour les inputs
  static const Color inputBackground = Color(0xFF2A2A2A);
  static const Color surfaceVariant = Color(0xFF2A2A2A);

  /// Bordures - Vert ESS
  static const Color border = Color(0xFF3ADF7C);
  static const Color outline = Color(0xFF3ADF7C);

  /// Couleur pour les éléments désactivés
  static const Color disabled = Color(0xFF404040);

  // === COULEURS DE BOUTONS ===

  /// Bouton principal - Vert ESS
  static const Color buttonPrimary = Color(0xFF3ADF7C);

  /// Bouton secondaire - Cyan ESS
  static const Color buttonSecondary = Color(0xFF00B8D9);

  /// Bouton désactivé
  static const Color buttonDisabled = Color(0xFF404040);

  // === COULEURS PAR STATUT DE MISSION ===

  /// Mission disponible
  static const Color statusAvailable = Color(0xFF3ADF7C);

  /// Mission en cours
  static const Color statusInProgress = Color(0xFF00B8D9);

  /// Mission terminée
  static const Color statusCompleted = Color(0xFF4ADE80);

  /// Mission en retard
  static const Color statusOverdue = Color(0xFFFF4D4F);

  // === GRADIENTS ESS ===

  /// Gradient principal (vert vers cyan)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF3ADF7C), Color(0xFF00B8D9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Gradient de fond sombre
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFF0A0A0A), Color(0xFF1A1A1A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Rétro-compatibilité avec l'ancien code
  static const Color primaryBackground = Color(0xFF1A1A1A);
  static const Color accentGreenDark = Color(0xFF118D57);
}

// Constantes de design
class AppSizes {
  // Espacements
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;

  // Rayons de bordure
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusXL = 16.0;
  static const double radiusXXL = 24.0;

  // Tailles d'icônes
  static const double iconS = 16.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 48.0;

  // Hauteurs des composants
  static const double buttonHeight = 48.0;
  static const double inputHeight = 56.0;
  static const double appBarHeight = 56.0;
  static const double bottomNavHeight = 60.0;

  // Largeurs maximales
  static const double maxWidthMobile = 480.0;
  static const double maxWidthTablet = 768.0;
  static const double maxWidthDesktop = 1200.0;
}
