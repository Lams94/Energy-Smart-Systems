import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Barre de navigation bottom personnalisée selon la charte Energy Smart Systems
/// Fond #1A1A1A avec accents verts #3ADF7C et animations fluides
class BottomNavigationBarEss extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final List<BottomNavigationBarEssItem> items;
  final bool showLabels;
  final Color? backgroundColor;
  final double elevation;

  const BottomNavigationBarEss({
    super.key,
    required this.currentIndex,
    required this.items,
    this.onTap,
    this.showLabels = true,
    this.backgroundColor,
    this.elevation = 8,
  });

  @override
  State<BottomNavigationBarEss> createState() => _BottomNavigationBarEssState();
}

class _BottomNavigationBarEssState extends State<BottomNavigationBarEss>
    with TickerProviderStateMixin {
  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _scaleAnimations;
  late List<Animation<double>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationControllers = List.generate(
      widget.items.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      ),
    );

    _scaleAnimations = _animationControllers.map((controller) {
      return Tween<double>(
        begin: 1.0,
        end: 1.2,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    }).toList();

    _slideAnimations = _animationControllers.map((controller) {
      return Tween<double>(
        begin: 0.0,
        end: -4.0,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    }).toList();

    // Animer l'item sélectionné
    if (widget.currentIndex < _animationControllers.length) {
      _animationControllers[widget.currentIndex].forward();
    }
  }

  @override
  void didUpdateWidget(BottomNavigationBarEss oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Mettre à jour les animations lors du changement d'index
    if (oldWidget.currentIndex != widget.currentIndex) {
      if (oldWidget.currentIndex < _animationControllers.length) {
        _animationControllers[oldWidget.currentIndex].reverse();
      }
      if (widget.currentIndex < _animationControllers.length) {
        _animationControllers[widget.currentIndex].forward();
      }
    }
  }

  @override
  void dispose() {
    for (final controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // Fond navigation ESS #1A1A1A
        color: widget.backgroundColor ?? AppColors.surface,
        // Bordure supérieure verte ESS subtile
        border: Border(
          top: BorderSide(
            color: AppColors.border.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        // Ombre pour effet de profondeur
        boxShadow: [
          BoxShadow(
            color: AppColors.background.withValues(alpha: 0.8),
            blurRadius: widget.elevation,
            offset: Offset(0, -widget.elevation / 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 72,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              widget.items.length,
              (index) => _buildNavigationItem(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationItem(int index) {
    final item = widget.items[index];
    final isSelected = index == widget.currentIndex;

    return Expanded(
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _scaleAnimations[index],
          _slideAnimations[index],
        ]),
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimations[index].value,
            child: Transform.translate(
              offset: Offset(0, _slideAnimations[index].value),
              child: _buildItemContent(item, index, isSelected),
            ),
          );
        },
      ),
    );
  }

  Widget _buildItemContent(
    BottomNavigationBarEssItem item,
    int index,
    bool isSelected,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _onItemTap(index),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            // Fond sélectionné avec gradient ESS
            gradient: isSelected
                ? LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.1), // #3ADF7C
                      AppColors.secondary.withValues(alpha: 0.05), // #00B8D9
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            borderRadius: BorderRadius.circular(12),
            // Bordure verte pour l'item sélectionné
            border: isSelected
                ? Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    width: 1,
                  )
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icône avec animation et badge
              Stack(
                children: [
                  Icon(
                    isSelected ? item.activeIcon ?? item.icon : item.icon,
                    color: isSelected
                        ? AppColors
                              .primary // #3ADF7C pour sélectionné
                        : AppColors
                              .textSecondary, // #B0B0B0 pour non-sélectionné
                    size: 24,
                  ),
                  // Badge de notification
                  if (item.badgeCount > 0)
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        width: 12,
                        height: 12,
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: AppColors.error, // #FF4D4F
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: AppColors.surface,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            item.badgeCount > 9
                                ? '9+'
                                : item.badgeCount.toString(),
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              // Label avec animation
              if (widget.showLabels) ...[
                const SizedBox(height: 4),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    color: isSelected
                        ? AppColors
                              .primary // #3ADF7C pour sélectionné
                        : AppColors
                              .textSecondary, // #B0B0B0 pour non-sélectionné
                    fontSize: isSelected ? 12 : 11,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                  child: Text(
                    item.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTap(int index) {
    if (index != widget.currentIndex) {
      widget.onTap?.call(index);
    }
  }
}

/// Item de navigation pour la barre ESS
class BottomNavigationBarEssItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final int badgeCount;
  final String? tooltip;

  const BottomNavigationBarEssItem({
    required this.icon,
    required this.label,
    this.activeIcon,
    this.badgeCount = 0,
    this.tooltip,
  });
}

/// Items de navigation prédéfinis pour l'application ESS
class BottomNavEssItems {
  /// Item pour l'accueil/dashboard
  static const BottomNavigationBarEssItem dashboard =
      BottomNavigationBarEssItem(
        icon: Icons.dashboard_outlined,
        activeIcon: Icons.dashboard,
        label: 'Accueil',
        tooltip: 'Tableau de bord',
      );

  /// Item pour les missions
  static const BottomNavigationBarEssItem missions = BottomNavigationBarEssItem(
    icon: Icons.assignment_outlined,
    activeIcon: Icons.assignment,
    label: 'Missions',
    tooltip: 'Mes missions',
  );

  /// Item pour les rapports
  static const BottomNavigationBarEssItem reports = BottomNavigationBarEssItem(
    icon: Icons.description_outlined,
    activeIcon: Icons.description,
    label: 'Rapports',
    tooltip: 'Mes rapports',
  );

  /// Item pour le scanner
  static const BottomNavigationBarEssItem scanner = BottomNavigationBarEssItem(
    icon: Icons.qr_code_scanner_outlined,
    activeIcon: Icons.qr_code_scanner,
    label: 'Scanner',
    tooltip: 'Scanner QR Code',
  );

  /// Item pour le profil
  static const BottomNavigationBarEssItem profile = BottomNavigationBarEssItem(
    icon: Icons.person_outline,
    activeIcon: Icons.person,
    label: 'Profil',
    tooltip: 'Mon profil',
  );

  /// Item pour les paramètres
  static const BottomNavigationBarEssItem settings = BottomNavigationBarEssItem(
    icon: Icons.settings_outlined,
    activeIcon: Icons.settings,
    label: 'Paramètres',
    tooltip: 'Paramètres',
  );

  /// Item pour les notifications avec badge
  static BottomNavigationBarEssItem notifications({int badgeCount = 0}) {
    return BottomNavigationBarEssItem(
      icon: Icons.notifications_outlined,
      activeIcon: Icons.notifications,
      label: 'Notifications',
      tooltip: 'Mes notifications',
      badgeCount: badgeCount,
    );
  }
}
