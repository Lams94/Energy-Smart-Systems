import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Widget pour afficher le logo Energy Smart Systems
/// Adaptatif selon le contexte d'utilisation
class LogoEss extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxFit fit;
  final bool showFallback;
  final Color? fallbackBackgroundColor;
  final String? fallbackText;

  const LogoEss({
    super.key,
    this.width = 120,
    this.height = 120,
    this.fit = BoxFit.contain,
    this.showFallback = true,
    this.fallbackBackgroundColor,
    this.fallbackText,
  });

  /// Logo petit pour AppBar
  const LogoEss.small({
    super.key,
    this.fit = BoxFit.contain,
    this.showFallback = true,
    this.fallbackBackgroundColor,
    this.fallbackText,
  }) : width = 40,
       height = 40;

  /// Logo moyen pour cards
  const LogoEss.medium({
    super.key,
    this.fit = BoxFit.contain,
    this.showFallback = true,
    this.fallbackBackgroundColor,
    this.fallbackText,
  }) : width = 80,
       height = 80;

  /// Logo large pour splash/header
  const LogoEss.large({
    super.key,
    this.fit = BoxFit.contain,
    this.showFallback = true,
    this.fallbackBackgroundColor,
    this.fallbackText,
  }) : width = 160,
       height = 160;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Image.asset(
        'assets/images/logo.png',
        width: width,
        height: height,
        fit: fit,
        errorBuilder: showFallback ? _buildFallback : null,
      ),
    );
  }

  /// Widget de fallback en cas d'erreur de chargement
  Widget _buildFallback(BuildContext context, Object error, StackTrace? stackTrace) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        // Gradient ESS ou couleur personnalisée
        gradient: fallbackBackgroundColor == null
            ? LinearGradient(
                colors: [
                  AppColors.primary,   // #3ADF7C
                  AppColors.secondary, // #00B8D9
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: fallbackBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        // Ombre subtile
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          fallbackText ?? 'ESS',
          style: TextStyle(
            color: AppColors.background,
            fontSize: _getFallbackFontSize(),
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  /// Taille de police adaptative pour le fallback
  double _getFallbackFontSize() {
    if (width == null) return 16;
    
    if (width! <= 40) return 10;
    if (width! <= 80) return 16;
    if (width! <= 120) return 24;
    return 32;
  }
}

/// Widget pour splash screen avec logo ESS
class SplashLogoEss extends StatelessWidget {
  final double logoSize;
  final String? subtitle;
  final bool animate;

  const SplashLogoEss({
    super.key,
    this.logoSize = 200,
    this.subtitle,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget logoWidget = LogoEss.large();
    
    if (animate) {
      logoWidget = TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 1000),
        tween: Tween(begin: 0.0, end: 1.0),
        curve: Curves.elasticOut,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: Opacity(
              opacity: value,
              child: child,
            ),
          );
        },
        child: logoWidget,
      );
    }

    return Container(
      color: AppColors.background, // Fond noir ESS
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logoWidget,
            
            if (subtitle != null) ...[
              const SizedBox(height: 32),
              Text(
                subtitle!,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.center,
              ),
            ],
            
            const SizedBox(height: 48),
            
            // Indicateur de chargement ESS
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Indicateur de chargement avec logo ESS
class LoadingEss extends StatelessWidget {
  final String? message;
  final double logoSize;

  const LoadingEss({
    super.key,
    this.message,
    this.logoSize = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background.withValues(alpha: 0.9),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.border.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LogoEss(
                width: logoSize,
                height: logoSize,
              ),
              
              const SizedBox(height: 16),
              
              SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  strokeWidth: 2,
                ),
              ),
              
              if (message != null) ...[
                const SizedBox(height: 16),
                Text(
                  message!,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
