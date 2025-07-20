import 'package:flutter/material.dart';
import '../widgets/app_bar_ess.dart';
import '../widgets/bottom_navigation_bar_ess.dart';
import '../widgets/floating_action_button_ess.dart';
import '../widgets/mission_card.dart';
import '../../core/constants/app_colors.dart';

/// Écran d'exemple démontrant l'intégration complète de la charte ESS
/// Utilise tous les composants personnalisés avec la palette de couleurs officielle
class HomeScreenEss extends StatefulWidget {
  const HomeScreenEss({super.key});

  @override
  State<HomeScreenEss> createState() => _HomeScreenEssState();
}

class _HomeScreenEssState extends State<HomeScreenEss> {
  int _currentIndex = 0;
  bool _isLoading = false;

  // Données de démonstration
  final List<Map<String, dynamic>> _mockMissions = [
    {
      'title': 'Maintenance préventive',
      'description': 'Vérification des équipements électriques du bâtiment A',
      'status': 'Disponible',
      'deadline': DateTime.now().add(const Duration(days: 2)),
      'location': 'Site Industriel Nord',
    },
    {
      'title': 'Installation capteurs',
      'description': 'Mise en place du système de monitoring énergétique',
      'status': 'En cours',
      'deadline': DateTime.now().add(const Duration(days: 1)),
      'location': 'Bureau Central',
    },
    {
      'title': 'Audit énergétique',
      'description': 'Analyse de la consommation du secteur production',
      'status': 'Terminé',
      'deadline': DateTime.now().subtract(const Duration(days: 1)),
      'location': 'Zone Production',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fond principal ESS #0A0A0A
      backgroundColor: AppColors.background,

      // AppBar personnalisée ESS
      appBar: AppBarEss(
        title: 'Energy Smart Systems',
        showLogo: true,
        actions: [
          AppBarEssActions.notificationButton(
            onPressed: _handleNotifications,
            badgeCount: 3,
          ),
          AppBarEssActions.menuButton(
            onPressed: _handleMenu,
            icon: Icons.person_outline,
          ),
        ],
      ),

      // Corps principal avec contenu adaptatif
      body: _buildBody(),

      // Bouton d'action flottant ESS
      floatingActionButton: FabEssPresets.addMission(
        onPressed: _handleAddMission,
        isLoading: _isLoading,
      ),

      // Navigation bottom ESS
      bottomNavigationBar: BottomNavigationBarEss(
        currentIndex: _currentIndex,
        onTap: _handleBottomNavTap,
        items: const [
          BottomNavEssItems.dashboard,
          BottomNavEssItems.missions,
          BottomNavEssItems.reports,
          BottomNavEssItems.scanner,
          BottomNavEssItems.profile,
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _buildDashboard();
      case 1:
        return _buildMissions();
      case 2:
        return _buildReports();
      case 3:
        return _buildScanner();
      case 4:
        return _buildProfile();
      default:
        return _buildDashboard();
    }
  }

  /// Dashboard principal avec statistiques ESS
  Widget _buildDashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Message de bienvenue
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              // Gradient ESS pour le header
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.1), // #3ADF7C
                  AppColors.secondary.withValues(alpha: 0.05), // #00B8D9
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.border.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bienvenue dans ESS',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Gérez vos missions et optimisez votre efficacité énergétique',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Statistiques rapides
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Missions actives',
                  '3',
                  Icons.assignment,
                  AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Rapports',
                  '12',
                  Icons.description,
                  AppColors.secondary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Efficacité',
                  '94%',
                  Icons.trending_up,
                  AppColors.success,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Alertes',
                  '1',
                  Icons.warning,
                  AppColors.warning,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Section missions récentes
          Text(
            'Missions récentes',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 16),

          // Liste des missions
          ..._mockMissions
              .take(2)
              .map(
                (mission) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: MissionCard(
                    title: mission['title'],
                    description: mission['description'],
                    status: mission['status'],
                    deadline: mission['deadline'],
                    location: mission['location'],
                    onTap: () => _handleMissionTap(mission),
                  ),
                ),
              ),
        ],
      ),
    );
  }

  /// Widget pour les cartes de statistiques
  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontFamily: 'Inter',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Page des missions
  Widget _buildMissions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _mockMissions.length,
      itemBuilder: (context, index) {
        final mission = _mockMissions[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: MissionCard(
            title: mission['title'],
            description: mission['description'],
            status: mission['status'],
            deadline: mission['deadline'],
            location: mission['location'],
            onTap: () => _handleMissionTap(mission),
          ),
        );
      },
    );
  }

  /// Page des rapports (placeholder)
  Widget _buildReports() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.description_outlined,
            size: 64,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            'Rapports',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Vos rapports apparaîtront ici',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  /// Page du scanner (placeholder)
  Widget _buildScanner() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.qr_code_scanner, size: 64, color: AppColors.primary),
          const SizedBox(height: 16),
          Text(
            'Scanner QR Code',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Scannez un QR code pour accéder rapidement aux informations',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
              fontFamily: 'Inter',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Page du profil (placeholder)
  Widget _buildProfile() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_outline, size: 64, color: AppColors.textSecondary),
          const SizedBox(height: 16),
          Text(
            'Profil',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Gérez votre profil et vos paramètres',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  // Gestionnaires d'événements
  void _handleBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _handleNotifications() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notifications ouvertes'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _handleMenu() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Menu ouvert'),
        backgroundColor: AppColors.secondary,
      ),
    );
  }

  void _handleAddMission() {
    setState(() {
      _isLoading = true;
    });

    // Simulation d'une action asynchrone
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Nouvelle mission créée'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    });
  }

  void _handleMissionTap(Map<String, dynamic> mission) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Mission sélectionnée: ${mission['title']}'),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
