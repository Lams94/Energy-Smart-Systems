import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/models.dart';
import '../../providers/providers.dart';

/// Écran de gestion des dossiers
class DossiersScreen extends StatefulWidget {
  const DossiersScreen({super.key});

  @override
  State<DossiersScreen> createState() => _DossiersScreenState();
}

class _DossiersScreenState extends State<DossiersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'Tous';
  bool _isGridView = true;

  @override
  void initState() {
    super.initState();
    // Charger les dossiers au démarrage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DossierProvider>().loadAllDossiers();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          _buildViewToggle(),
          Expanded(child: _buildDossiersList()),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textPrimary,
      title: const Text(
        'Dossiers',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {
            // TODO: Naviguer vers les notifications
          },
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            // TODO: Afficher le menu contextuel
          },
        ),
      ],
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Barre de recherche
          TextField(
            controller: _searchController,
            onChanged: (value) {
              // TODO: Implémenter la recherche
            },
            decoration: InputDecoration(
              hintText: 'Rechercher un dossier...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: AppColors.surface,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Filtres
          _buildFilters(),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    final filters = ['Tous', 'En cours', 'Terminés', 'En attente', 'Urgents'];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = _selectedFilter == filter;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedFilter = filter;
                });
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
            ),
          );
        },
      ),
    );
  }

  Widget _buildViewToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Consumer<DossierProvider>(
            builder: (context, dossierProvider, child) {
              return Text(
                '${dossierProvider.dossiers.length} dossier(s)',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
              );
            },
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.grid_view,
                  color: _isGridView ? AppColors.primary : AppColors.textMuted,
                ),
                onPressed: () {
                  setState(() {
                    _isGridView = true;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.list,
                  color: !_isGridView ? AppColors.primary : AppColors.textMuted,
                ),
                onPressed: () {
                  setState(() {
                    _isGridView = false;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDossiersList() {
    return Consumer<DossierProvider>(
      builder: (context, dossierProvider, child) {
        if (dossierProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          );
        }

        final dossiers = dossierProvider.dossiers;

        if (dossiers.isEmpty) {
          return _buildEmptyState();
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: _isGridView
              ? _buildGridView(dossiers)
              : _buildListView(dossiers),
        );
      },
    );
  }

  Widget _buildGridView(List<Dossier> dossiers) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: dossiers.length,
      itemBuilder: (context, index) {
        final dossier = dossiers[index];
        return _buildDossierCard(dossier);
      },
    );
  }

  Widget _buildListView(List<Dossier> dossiers) {
    return ListView.builder(
      itemCount: dossiers.length,
      itemBuilder: (context, index) {
        final dossier = dossiers[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildDossierListItem(dossier),
        );
      },
    );
  }

  Widget _buildDossierCard(Dossier dossier) {
    Color statusColor = _getStatusColor(dossier.status);

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {
          context.push('/dossier/${dossier.id}');
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getStatusIcon(dossier.status),
                      color: statusColor,
                      size: 20,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      dossier.status.label,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                dossier.numeroOSR,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                dossier.adresse,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 16,
                    color: AppColors.textMuted,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      dossier.contactClient,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textMuted,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                    color: AppColors.textMuted,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(dossier.dateCreation ?? DateTime.now()),
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDossierListItem(Dossier dossier) {
    Color statusColor = _getStatusColor(dossier.status);

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          context.push('/dossier/${dossier.id}');
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getStatusIcon(dossier.status),
                  color: statusColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            dossier.numeroOSR,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            dossier.status.label,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dossier.adresse,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 16,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            dossier.contactClient,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.textMuted),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 16,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatDate(dossier.dateCreation ?? DateTime.now()),
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right, color: AppColors.textMuted),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open_outlined,
            size: 64,
            color: AppColors.textMuted,
          ),
          const SizedBox(height: 16),
          Text(
            'Aucun dossier trouvé',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: 8),
          Text(
            'Créez votre premier dossier pour commencer',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Naviguer vers la création de dossier
            },
            icon: const Icon(Icons.add),
            label: const Text('Créer un dossier'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        // TODO: Naviguer vers la création de dossier
      },
      backgroundColor: AppColors.primary,
      child: const Icon(Icons.add, color: AppColors.textPrimary),
    );
  }

  Color _getStatusColor(DossierStatus status) {
    switch (status) {
      case DossierStatus.pending:
        return AppColors.warning;
      case DossierStatus.assigned:
        return AppColors.primary;
      case DossierStatus.inProgress:
        return AppColors.accentTurquoise;
      case DossierStatus.completed:
        return AppColors.success;
      case DossierStatus.validated:
        return AppColors.success;
      case DossierStatus.billed:
        return AppColors.accentGreenLight;
    }
  }

  IconData _getStatusIcon(DossierStatus status) {
    switch (status) {
      case DossierStatus.pending:
        return Icons.schedule;
      case DossierStatus.assigned:
        return Icons.assignment_ind;
      case DossierStatus.inProgress:
        return Icons.work_outline;
      case DossierStatus.completed:
        return Icons.check_circle_outline;
      case DossierStatus.validated:
        return Icons.verified_outlined;
      case DossierStatus.billed:
        return Icons.receipt_long;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
