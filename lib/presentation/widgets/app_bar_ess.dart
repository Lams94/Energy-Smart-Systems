import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// AppBar personnalisée selon la charte Energy Smart Systems
/// Fond #0A0A0A avec accents verts #3ADF7C et cyan #00B8D9
class AppBarEss extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final bool showLogo;
  final double elevation;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const AppBarEss({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.showBackButton = true,
    this.onBackPressed,
    this.showLogo = true,
    this.elevation = 0,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // Fond principal ESS #0A0A0A
        color: backgroundColor ?? AppColors.background,
        // Bordure inférieure verte ESS subtile
        border: Border(
          bottom: BorderSide(
            color: AppColors.primary.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        // Ombre subtile pour profondeur
        boxShadow: elevation > 0
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: SafeArea(
        child: Container(
          height: kToolbarHeight,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // Bouton retour ou leading personnalisé
              if (leading != null)
                leading!
              else if (showBackButton && Navigator.of(context).canPop())
                _buildBackButton(context),

              // Logo ESS (optionnel)
              if (showLogo &&
                  leading == null &&
                  (!showBackButton || !Navigator.of(context).canPop()))
                _buildLogo(),

              // Espacement
              if ((leading != null ||
                  (showBackButton && Navigator.of(context).canPop()) ||
                  (showLogo &&
                      leading == null &&
                      (!showBackButton || !Navigator.of(context).canPop()))))
                const SizedBox(width: 16),

              // Titre avec style ESS
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    // Couleur titre blanc ESS #FFFFFF
                    color: foregroundColor ?? AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins', // Typographie ESS
                    letterSpacing: -0.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Actions personnalisées
              if (actions != null) ...[
                const SizedBox(width: 8),
                Row(mainAxisSize: MainAxisSize.min, children: actions!),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// Bouton retour avec style ESS
  Widget _buildBackButton(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        // Fond subtil pour le bouton
        color: AppColors.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        // Bordure verte ESS subtile
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onBackPressed ?? () => Navigator.of(context).pop(),
          borderRadius: BorderRadius.circular(8),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primary, // Icône verte ESS #3ADF7C
            size: 20,
          ),
        ),
      ),
    );
  }

  /// Logo ESS avec vrai logo
  Widget _buildLogo() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        // Ombre pour effet de profondeur
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          'assets/images/logo.png',
          width: 40,
          height: 40,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            // Fallback en cas d'erreur de chargement
            return Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                // Gradient ESS vert -> cyan comme fallback
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary, // #3ADF7C
                    AppColors.secondary, // #00B8D9
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'ESS',
                  style: TextStyle(
                    color: AppColors.background,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Actions communes pour l'AppBar ESS
class AppBarEssActions {
  /// Bouton de notification avec badge
  static Widget notificationButton({
    required VoidCallback onPressed,
    int badgeCount = 0,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Stack(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.border.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onPressed,
                borderRadius: BorderRadius.circular(8),
                child: Icon(
                  Icons.notifications_outlined,
                  color: AppColors.textPrimary,
                  size: 20,
                ),
              ),
            ),
          ),
          if (badgeCount > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 16,
                height: 16,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: AppColors.error, // #FF4D4F
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.background, width: 1),
                ),
                child: Center(
                  child: Text(
                    badgeCount > 99 ? '99+' : badgeCount.toString(),
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Bouton de menu/profil
  static Widget menuButton({
    required VoidCallback onPressed,
    IconData icon = Icons.menu,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Icon(icon, color: AppColors.textPrimary, size: 20),
        ),
      ),
    );
  }

  /// Bouton de recherche
  static Widget searchButton({required VoidCallback onPressed}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Icon(Icons.search, color: AppColors.textPrimary, size: 20),
        ),
      ),
    );
  }
}
