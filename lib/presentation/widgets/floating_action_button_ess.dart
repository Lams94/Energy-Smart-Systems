import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Bouton d'action flottant personnalisé selon la charte Energy Smart Systems
/// Gradient vert #3ADF7C vers cyan #00B8D9 avec ombres et animations
class FloatingActionButtonEss extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final IconData? icon;
  final String? tooltip;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final bool isExtended;
  final String? label;
  final bool isLoading;

  const FloatingActionButtonEss({
    super.key,
    this.onPressed,
    this.child,
    this.icon,
    this.tooltip,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 6,
    this.isExtended = false,
    this.label,
    this.isLoading = false,
  });

  /// Constructeur pour bouton étendu avec label
  const FloatingActionButtonEss.extended({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.tooltip,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 6,
    this.isLoading = false,
  }) : isExtended = true,
       child = null;

  /// Constructeur pour bouton avec icône
  const FloatingActionButtonEss.icon({
    super.key,
    required this.onPressed,
    required this.icon,
    this.tooltip,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 6,
    this.isLoading = false,
  }) : isExtended = false,
       child = null,
       label = null;

  @override
  State<FloatingActionButtonEss> createState() =>
      _FloatingActionButtonEssState();
}

class _FloatingActionButtonEssState extends State<FloatingActionButtonEss>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: _buildButton(),
          ),
        );
      },
    );
  }

  Widget _buildButton() {
    final isEnabled = widget.onPressed != null && !widget.isLoading;

    return Container(
      decoration: BoxDecoration(
        // Gradient ESS vert vers cyan
        gradient: isEnabled
            ? LinearGradient(
                colors: [
                  widget.backgroundColor ?? AppColors.primary, // #3ADF7C
                  AppColors.secondary, // #00B8D9
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: !isEnabled
            ? AppColors.textSecondary.withValues(alpha: 0.3)
            : null,
        borderRadius: BorderRadius.circular(widget.isExtended ? 28 : 28),
        // Ombres pour effet de profondeur
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.4),
                  blurRadius: widget.elevation * 2,
                  offset: Offset(0, widget.elevation),
                ),
                BoxShadow(
                  color: AppColors.secondary.withValues(alpha: 0.2),
                  blurRadius: widget.elevation,
                  offset: Offset(widget.elevation / 2, 0),
                ),
              ]
            : [
                BoxShadow(
                  color: AppColors.textSecondary.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? widget.onPressed : null,
          onTapDown: isEnabled ? _onTapDown : null,
          onTapUp: isEnabled ? _onTapUp : null,
          onTapCancel: isEnabled ? _onTapCancel : null,
          borderRadius: BorderRadius.circular(widget.isExtended ? 28 : 28),
          child: Container(
            height: 56,
            width: widget.isExtended ? null : 56,
            padding: widget.isExtended
                ? const EdgeInsets.symmetric(horizontal: 20, vertical: 16)
                : const EdgeInsets.all(16),
            child: _buildButtonContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonContent() {
    final contentColor = widget.foregroundColor ?? AppColors.background;

    if (widget.isLoading) {
      return Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(color: contentColor, strokeWidth: 2),
        ),
      );
    }

    if (widget.isExtended && widget.label != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.icon != null) ...[
            Icon(widget.icon, color: contentColor, size: 24),
            const SizedBox(width: 12),
          ],
          Text(
            widget.label!,
            style: TextStyle(
              color: contentColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              letterSpacing: 0.5,
            ),
          ),
        ],
      );
    }

    if (widget.child != null) {
      return Center(child: widget.child!);
    }

    return Center(
      child: Icon(widget.icon ?? Icons.add, color: contentColor, size: 24),
    );
  }
}

/// Boutons d'action flottant prédéfinis pour l'application ESS
class FabEssPresets {
  /// FAB pour ajouter une nouvelle mission
  static FloatingActionButtonEss addMission({
    required VoidCallback onPressed,
    bool isLoading = false,
  }) {
    return FloatingActionButtonEss.extended(
      onPressed: isLoading ? null : onPressed,
      icon: Icons.add_task,
      label: 'Nouvelle mission',
      tooltip: 'Créer une nouvelle mission',
      isLoading: isLoading,
    );
  }

  /// FAB pour scanner un QR code
  static FloatingActionButtonEss scanQr({
    required VoidCallback onPressed,
    bool isLoading = false,
  }) {
    return FloatingActionButtonEss.icon(
      onPressed: isLoading ? null : onPressed,
      icon: Icons.qr_code_scanner,
      tooltip: 'Scanner QR Code',
      isLoading: isLoading,
    );
  }

  /// FAB pour créer un rapport
  static FloatingActionButtonEss createReport({
    required VoidCallback onPressed,
    bool isLoading = false,
  }) {
    return FloatingActionButtonEss.extended(
      onPressed: isLoading ? null : onPressed,
      icon: Icons.description,
      label: 'Nouveau rapport',
      tooltip: 'Créer un rapport',
      isLoading: isLoading,
    );
  }

  /// FAB pour synchroniser
  static FloatingActionButtonEss sync({
    required VoidCallback onPressed,
    bool isLoading = false,
  }) {
    return FloatingActionButtonEss.icon(
      onPressed: isLoading ? null : onPressed,
      icon: Icons.sync,
      tooltip: 'Synchroniser',
      isLoading: isLoading,
    );
  }

  /// FAB pour appeler d'urgence
  static FloatingActionButtonEss emergency({
    required VoidCallback onPressed,
    bool isLoading = false,
  }) {
    return FloatingActionButtonEss.icon(
      onPressed: isLoading ? null : onPressed,
      icon: Icons.emergency,
      tooltip: 'Urgence',
      backgroundColor: AppColors.error,
      isLoading: isLoading,
    );
  }
}
