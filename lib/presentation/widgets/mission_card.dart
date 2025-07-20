import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Widget de carte pour afficher une mission
class MissionCard extends StatelessWidget {
  const MissionCard({
    super.key,
    required this.title,
    required this.description,
    required this.status,
    required this.deadline,
    required this.location,
    this.onTap,
  });

  final String title;
  final String description;
  final String status;
  final DateTime deadline;
  final String location;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final daysRemaining = deadline.difference(DateTime.now()).inDays;
    final isOverdue = daysRemaining < 0;
    final isUrgent = daysRemaining <= 2 && !isOverdue;

    Color statusColor;
    switch (status.toLowerCase()) {
      case 'en cours':
        statusColor = AppColors.warning;
        break;
      case 'terminé':
      case 'terminée':
        statusColor = AppColors.success;
        break;
      case 'en retard':
        statusColor = AppColors.error;
        break;
      default:
        statusColor = AppColors.primary;
    }

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header avec titre et statut
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      status,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Description
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 12),

              // Footer avec localisation et deadline
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      location,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Icon(
                    isOverdue
                        ? Icons.schedule
                        : isUrgent
                        ? Icons.warning_outlined
                        : Icons.access_time,
                    size: 16,
                    color: isOverdue
                        ? AppColors.error
                        : isUrgent
                        ? AppColors.warning
                        : AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    isOverdue
                        ? 'En retard'
                        : daysRemaining == 0
                        ? "Aujourd'hui"
                        : daysRemaining == 1
                        ? 'Demain'
                        : '$daysRemaining j',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isOverdue
                          ? AppColors.error
                          : isUrgent
                          ? AppColors.warning
                          : AppColors.textSecondary,
                      fontWeight: (isOverdue || isUrgent)
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
