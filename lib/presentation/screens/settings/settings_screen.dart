import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Écran de paramètres de l'application
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _syncEnabled = true;
  String _selectedLanguage = 'Français';

  final List<String> _languages = ['Français', 'English', 'Español'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildNotificationsSection(),
            _buildAppearanceSection(),
            _buildSyncSection(),
            _buildLanguageSection(),
            _buildAboutSection(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textPrimary,
      title: const Text(
        'Paramètres',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildNotificationsSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Notifications',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          _buildSwitchItem(
            icon: Icons.notifications_none,
            title: 'Notifications push',
            subtitle: 'Recevoir des notifications sur votre appareil',
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          const Divider(height: 1),
          _buildSettingsItem(
            icon: Icons.schedule,
            title: 'Horaires de notification',
            subtitle: 'Gérer les heures de réception',
            onTap: () {
              // TODO: Naviguer vers les horaires
            },
          ),
          const Divider(height: 1),
          _buildSettingsItem(
            icon: Icons.volume_up,
            title: 'Sons et vibrations',
            subtitle: 'Personnaliser les alertes',
            onTap: () {
              // TODO: Naviguer vers les sons
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAppearanceSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Apparence',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          _buildSwitchItem(
            icon: Icons.dark_mode,
            title: 'Mode sombre',
            subtitle: 'Activer le thème sombre',
            value: _darkModeEnabled,
            onChanged: (value) {
              setState(() {
                _darkModeEnabled = value;
              });
              // TODO: Changer le thème
            },
          ),
          const Divider(height: 1),
          _buildSettingsItem(
            icon: Icons.palette,
            title: 'Couleurs',
            subtitle: 'Personnaliser les couleurs',
            onTap: () {
              // TODO: Naviguer vers les couleurs
            },
          ),
          const Divider(height: 1),
          _buildSettingsItem(
            icon: Icons.text_fields,
            title: 'Taille du texte',
            subtitle: 'Ajuster la taille de la police',
            onTap: () {
              // TODO: Naviguer vers la taille du texte
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSyncSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Synchronisation',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          _buildSwitchItem(
            icon: Icons.sync,
            title: 'Synchronisation automatique',
            subtitle: 'Synchroniser les données automatiquement',
            value: _syncEnabled,
            onChanged: (value) {
              setState(() {
                _syncEnabled = value;
              });
            },
          ),
          const Divider(height: 1),
          _buildSettingsItem(
            icon: Icons.wifi,
            title: 'Synchronisation Wi-Fi uniquement',
            subtitle: 'Limiter la sync au Wi-Fi',
            onTap: () {
              // TODO: Naviguer vers les paramètres de sync
            },
          ),
          const Divider(height: 1),
          _buildSettingsItem(
            icon: Icons.backup,
            title: 'Sauvegardes',
            subtitle: 'Gérer les sauvegardes de données',
            onTap: () {
              // TODO: Naviguer vers les sauvegardes
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Langue et région',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          _buildDropdownItem(
            icon: Icons.language,
            title: 'Langue',
            value: _selectedLanguage,
            items: _languages,
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value!;
              });
            },
          ),
          const Divider(height: 1),
          _buildSettingsItem(
            icon: Icons.location_on,
            title: 'Région',
            subtitle: 'France (FR)',
            onTap: () {
              // TODO: Naviguer vers les régions
            },
          ),
          const Divider(height: 1),
          _buildSettingsItem(
            icon: Icons.schedule,
            title: 'Format de date et heure',
            subtitle: 'DD/MM/YYYY - 24h',
            onTap: () {
              // TODO: Naviguer vers les formats
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'À propos',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          _buildSettingsItem(
            icon: Icons.info,
            title: 'Version de l\'application',
            subtitle: '1.0.0',
            onTap: () {
              // TODO: Afficher les informations de version
            },
          ),
          const Divider(height: 1),
          _buildSettingsItem(
            icon: Icons.privacy_tip,
            title: 'Politique de confidentialité',
            subtitle: 'Consulter notre politique',
            onTap: () {
              // TODO: Naviguer vers la politique
            },
          ),
          const Divider(height: 1),
          _buildSettingsItem(
            icon: Icons.description,
            title: 'Conditions d\'utilisation',
            subtitle: 'Lire les conditions',
            onTap: () {
              // TODO: Naviguer vers les conditions
            },
          ),
          const Divider(height: 1),
          _buildSettingsItem(
            icon: Icons.feedback,
            title: 'Envoyer un feedback',
            subtitle: 'Nous faire part de vos commentaires',
            onTap: () {
              // TODO: Naviguer vers le feedback
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: AppColors.textMuted),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownItem({
    required IconData icon,
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          DropdownButton<String>(
            value: value,
            onChanged: onChanged,
            items: items.map((String item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
            underline: Container(),
            icon: Icon(Icons.arrow_drop_down, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
