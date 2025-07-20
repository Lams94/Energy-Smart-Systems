import '../../data/models/models.dart';

/// Repository pour la gestion des dossiers
class DossierRepository {
  // Données de démonstration
  static final List<Dossier> _dossiers = [
    Dossier(
      id: 'dossier_1',
      numeroOSR: 'OSR123456',
      adresse: '123 Rue de la Paix, 75001 Paris',
      departement: 'Paris (75)',
      contactClient: 'Jean Dupont - 01.23.45.67.89',
      natureDemande: 'Raccordement résidentiel - Installation photovoltaïque',
      dateLimiteRendu: DateTime.now().add(const Duration(days: 7)),
      status: DossierStatus.assigned,
      assignedUserId: 'demo_user_123',
      assignedUserName: 'John Doe',
      priority: DossierPriority.medium,
      montantEstime: 1250.0,
      dateCreation: DateTime.now().subtract(const Duration(days: 3)),
      dateAssignation: DateTime.now().subtract(const Duration(days: 2)),
      etapesCompletees: ['visite_reconnaissance', 'analyse_existant'],
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Dossier(
      id: 'dossier_2',
      numeroOSR: 'OSR789012',
      adresse: '456 Avenue des Champs, 69003 Lyon',
      departement: 'Rhône (69)',
      contactClient: 'Marie Martin - 04.56.78.90.12',
      natureDemande: 'Raccordement commercial - Agrandissement magasin',
      dateLimiteRendu: DateTime.now().add(const Duration(days: 2)),
      status: DossierStatus.inProgress,
      assignedUserId: 'demo_user_123',
      assignedUserName: 'John Doe',
      priority: DossierPriority.high,
      montantEstime: 2800.0,
      dateCreation: DateTime.now().subtract(const Duration(days: 5)),
      dateAssignation: DateTime.now().subtract(const Duration(days: 4)),
      etapesCompletees: ['visite_reconnaissance'],
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 6)),
    ),
    Dossier(
      id: 'dossier_3',
      numeroOSR: 'OSR345678',
      adresse: '789 Boulevard du Soleil, 13008 Marseille',
      departement: 'Bouches-du-Rhône (13)',
      contactClient: 'Pierre Durand - 04.91.23.45.67',
      natureDemande: 'Raccordement industriel - Nouvelle unité de production',
      dateLimiteRendu: DateTime.now().subtract(const Duration(days: 1)),
      status: DossierStatus.inProgress,
      assignedUserId: 'demo_user_123',
      assignedUserName: 'John Doe',
      priority: DossierPriority.urgent,
      montantEstime: 5500.0,
      dateCreation: DateTime.now().subtract(const Duration(days: 10)),
      dateAssignation: DateTime.now().subtract(const Duration(days: 8)),
      etapesCompletees: [
        'visite_reconnaissance',
        'analyse_existant',
        'calcul_dimensionnement',
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 12)),
    ),
  ];

  /// Récupère tous les dossiers
  Future<List<Dossier>> getAllDossiers() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_dossiers);
  }

  /// Récupère les dossiers assignés à un utilisateur
  Future<List<Dossier>> getDossiersByUser(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _dossiers
        .where((dossier) => dossier.assignedUserId == userId)
        .toList();
  }

  /// Récupère un dossier par son ID
  Future<Dossier?> getDossierById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _dossiers.firstWhere((dossier) => dossier.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Crée un nouveau dossier
  Future<Dossier> createDossier(Dossier dossier) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final newDossier = dossier.copyWith(
      id: 'dossier_${DateTime.now().millisecondsSinceEpoch}',
      dateCreation: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _dossiers.add(newDossier);
    return newDossier;
  }

  /// Met à jour un dossier
  Future<Dossier> updateDossier(Dossier dossier) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final index = _dossiers.indexWhere((d) => d.id == dossier.id);
    if (index != -1) {
      final updatedDossier = dossier.copyWith(updatedAt: DateTime.now());
      _dossiers[index] = updatedDossier;
      return updatedDossier;
    }
    throw Exception('Dossier non trouvé');
  }

  /// Supprime un dossier
  Future<bool> deleteDossier(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final index = _dossiers.indexWhere((dossier) => dossier.id == id);
    if (index != -1) {
      _dossiers.removeAt(index);
      return true;
    }
    return false;
  }

  /// Assigne un dossier à un utilisateur
  Future<Dossier> assignDossier(
    String dossierId,
    String userId,
    String userName,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _dossiers.indexWhere((dossier) => dossier.id == dossierId);
    if (index != -1) {
      final updatedDossier = _dossiers[index].copyWith(
        assignedUserId: userId,
        assignedUserName: userName,
        status: DossierStatus.assigned,
        dateAssignation: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      _dossiers[index] = updatedDossier;
      return updatedDossier;
    }
    throw Exception('Dossier non trouvé');
  }

  /// Récupère les dossiers par statut
  Future<List<Dossier>> getDossiersByStatus(DossierStatus status) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _dossiers.where((dossier) => dossier.status == status).toList();
  }

  /// Récupère les dossiers en retard
  Future<List<Dossier>> getOverdueDossiers() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _dossiers.where((dossier) => dossier.isOverdue).toList();
  }

  /// Récupère les statistiques des dossiers
  Future<Map<String, dynamic>> getDossierStats() async {
    await Future.delayed(const Duration(milliseconds: 300));

    final total = _dossiers.length;
    final enCours = _dossiers
        .where((d) => d.status == DossierStatus.inProgress)
        .length;
    final termines = _dossiers
        .where((d) => d.status == DossierStatus.completed)
        .length;
    final enRetard = _dossiers.where((d) => d.isOverdue).length;
    final montantTotal = _dossiers.fold<double>(
      0.0,
      (sum, d) => sum + (d.montantEstime ?? 0.0),
    );

    return {
      'total': total,
      'enCours': enCours,
      'termines': termines,
      'enRetard': enRetard,
      'montantTotal': montantTotal,
      'tauxCompletion': total > 0 ? (termines / total * 100).round() : 0,
    };
  }
}
