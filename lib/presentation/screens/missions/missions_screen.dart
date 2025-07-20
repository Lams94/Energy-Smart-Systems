import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../widgets/widgets.dart';

/// Écran de gestion des missions
class MissionsScreen extends StatefulWidget {
  const MissionsScreen({super.key});

  @override
  State<MissionsScreen> createState() => _MissionsScreenState();
}

class _MissionsScreenState extends State<MissionsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.textPrimary,
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Missions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            color: AppColors.textPrimary,
            onPressed: _showFilterDialog,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: 'Mes missions'),
            Tab(text: 'Disponibles'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildMyMissionsTab(), _buildAvailableMissionsTab()],
      ),
    );
  }

  Widget _buildMyMissionsTab() {
    return RefreshIndicator(
      onRefresh: _refreshMyMissions,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Statistiques rapides
            _buildMissionStats(),

            const SizedBox(height: 24),

            // Filtres rapides
            _buildQuickFilters(),

            const SizedBox(height: 24),

            // Liste des missions
            Text(
              'Mes missions actives (5)',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // TODO: Remplacer par de vraies données
            ...List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: MissionCard(
                  title:
                      'Étude raccordement ${['OSR123456', 'OSR789012', 'OSR345678', 'OSR901234', 'OSR567890'][index]}',
                  description:
                      'Étude de faisabilité pour raccordement résidentiel - ${['Maison individuelle', 'Immeuble collectif', 'Commerce', 'Industrie', 'Bureau'][index]}',
                  status: [
                    'En cours',
                    'À faire',
                    'En cours',
                    'Terminé',
                    'En retard',
                  ][index],
                  deadline: DateTime.now().add(
                    Duration(days: [2, 5, -1, 0, 7][index]),
                  ),
                  location: [
                    'Paris 15e',
                    'Lyon 3e',
                    'Marseille 8e',
                    'Toulouse 1er',
                    'Nice 6e',
                  ][index],
                  onTap: () {
                    // TODO: Navigation vers détail mission
                    _showMissionDetail(index);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailableMissionsTab() {
    return RefreshIndicator(
      onRefresh: _refreshAvailableMissions,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Information sur les nouvelles missions
            _buildNewMissionsInfo(),

            const SizedBox(height: 24),

            Text(
              'Missions disponibles (8)',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // TODO: Remplacer par de vraies données
            ...List.generate(
              8,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildAvailableMissionCard(index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissionStats() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(child: _buildStatItem('En cours', '2', AppColors.warning)),
          Container(width: 1, height: 40, color: AppColors.border),
          Expanded(child: _buildStatItem('Terminées', '12', AppColors.success)),
          Container(width: 1, height: 40, color: AppColors.border),
          Expanded(
            child: _buildStatItem('CA mois', '3.2k€', AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildQuickFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip('Toutes', true),
          const SizedBox(width: 8),
          _buildFilterChip('En cours', false),
          const SizedBox(width: 8),
          _buildFilterChip('Urgentes', false),
          const SizedBox(width: 8),
          _buildFilterChip('Cette semaine', false),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        // TODO: Implémenter le filtrage
      },
      backgroundColor: AppColors.surface,
      selectedColor: AppColors.primary.withValues(alpha: 0.2),
      checkmarkColor: AppColors.primary,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
      ),
      side: BorderSide(
        color: isSelected ? AppColors.primary : AppColors.border,
      ),
    );
  }

  Widget _buildNewMissionsInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.1),
            AppColors.accentTurquoise.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.notifications_active, color: AppColors.primary, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '3 nouvelles missions cette semaine',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Postulez rapidement pour augmenter vos chances',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableMissionCard(int index) {
    final missions = [
      {
        'title': 'Étude raccordement OSR445566',
        'description':
            'Raccordement industriel complexe - Analyse technique approfondie requise',
        'location': 'Rennes',
        'budget': '1 200€',
        'difficulty': 'Expert',
        'deadline': 10,
        'applicants': 3,
      },
      {
        'title': 'Visite technique OSR778899',
        'description': 'Inspection préalable pour installation photovoltaïque',
        'location': 'Bordeaux',
        'budget': '450€',
        'difficulty': 'Intermédiaire',
        'deadline': 7,
        'applicants': 1,
      },
      // Ajoutez plus de missions...
    ];

    final mission = missions[index % missions.length];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  mission['title'] as String,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  mission['budget'] as String,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            mission['description'] as String,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                mission['location'] as String,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),

              const SizedBox(width: 16),

              Icon(Icons.schedule, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(
                '${mission['deadline']} jours',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),

              const Spacer(),

              Text(
                '${mission['applicants']} candidat(s)',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.warning),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _showMissionDetails(mission),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.primary),
                  ),
                  child: Text(
                    'Voir détails',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _applyToMission(mission),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  child: const Text(
                    'Postuler',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filtrer les missions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // TODO: Ajouter les filtres
            Text(
              'Fonctionnalité en cours de développement',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showMissionDetail(int index) {
    // TODO: Navigation vers détail mission
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Détail mission $index - À implémenter'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _showMissionDetails(Map<String, dynamic> mission) {
    // TODO: Afficher détails mission disponible
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Détails de ${mission['title']} - À implémenter'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _applyToMission(Map<String, dynamic> mission) {
    // TODO: Implémenter candidature
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Candidature à ${mission['title']} envoyée !'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  Future<void> _refreshMyMissions() async {
    // TODO: Refresh missions
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> _refreshAvailableMissions() async {
    // TODO: Refresh missions disponibles
    await Future.delayed(const Duration(seconds: 1));
  }
}
