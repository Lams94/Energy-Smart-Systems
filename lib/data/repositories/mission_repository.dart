import '../../data/models/models.dart';

/// Repository pour la gestion des missions
class MissionRepository {
  // Données de démonstration
  static final List<Mission> _missions = [
    Mission(
      id: 'mission_1',
      dossierId: 'dossier_1',
      title: 'Étude raccordement OSR123456',
      description:
          'Réalisation complète de l\'étude de raccordement pour une installation photovoltaïque résidentielle. Comprend visite technique, calculs et rapport.',
      status: MissionStatus.inProgress,
      dateCreation: DateTime.now().subtract(const Duration(days: 2)),
      assignedUserId: 'demo_user_123',
      assignedUserName: 'John Doe',
      requiredSkills: ['Électricité', 'Photovoltaïque', 'Rapport technique'],
      estimatedDuration: 16, // heures
      budgetEstime: 1250.0,
      deadline: DateTime.now().add(const Duration(days: 7)),
      location: 'Paris 1er',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    Mission(
      id: 'mission_2',
      dossierId: 'dossier_2',
      title: 'Étude raccordement OSR789012',
      description:
          'Étude de faisabilité pour l\'agrandissement d\'un magasin. Analyse des besoins électriques et proposition de solution.',
      status: MissionStatus.assigned,
      dateCreation: DateTime.now().subtract(const Duration(days: 4)),
      assignedUserId: 'demo_user_123',
      assignedUserName: 'John Doe',
      requiredSkills: [
        'Électricité commerciale',
        'Dimensionnement',
        'Réglementation',
      ],
      estimatedDuration: 24, // heures
      budgetEstime: 2800.0,
      deadline: DateTime.now().add(const Duration(days: 2)),
      location: 'Lyon 3e',
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Mission(
      id: 'mission_3',
      dossierId: 'dossier_3',
      title: 'Étude raccordement OSR345678',
      description:
          'Étude complexe pour raccordement industriel. Nouvelle unité de production nécessitant une analyse approfondie.',
      status: MissionStatus.inProgress,
      dateCreation: DateTime.now().subtract(const Duration(days: 8)),
      assignedUserId: 'demo_user_123',
      assignedUserName: 'John Doe',
      requiredSkills: ['Électricité industrielle', 'Haute tension', 'Sécurité'],
      estimatedDuration: 40, // heures
      budgetEstime: 5500.0,
      deadline: DateTime.now().subtract(const Duration(days: 1)), // En retard
      location: 'Marseille 8e',
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 12)),
    ),
  ];

  // Missions disponibles (non assignées)
  static final List<Mission> _availableMissions = [
    Mission(
      id: 'mission_available_1',
      dossierId: 'dossier_available_1',
      title: 'Étude raccordement OSR445566',
      description:
          'Raccordement industriel complexe nécessitant une expertise technique approfondie. Analyse des contraintes et dimensionnement.',
      status: MissionStatus.available,
      dateCreation: DateTime.now().subtract(const Duration(days: 1)),
      requiredSkills: [
        'Électricité industrielle',
        'Calculs avancés',
        'Réglementation',
      ],
      estimatedDuration: 32,
      budgetEstime: 4200.0,
      deadline: DateTime.now().add(const Duration(days: 10)),
      location: 'Rennes',
      applicantUserIds: ['user_2', 'user_3'],
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 6)),
    ),
    Mission(
      id: 'mission_available_2',
      dossierId: 'dossier_available_2',
      title: 'Visite technique OSR778899',
      description:
          'Inspection préalable pour installation photovoltaïque. Mission courte nécessitant une visite sur site et rapport.',
      status: MissionStatus.available,
      dateCreation: DateTime.now().subtract(const Duration(hours: 12)),
      requiredSkills: ['Photovoltaïque', 'Inspection', 'Rapport'],
      estimatedDuration: 8,
      budgetEstime: 650.0,
      deadline: DateTime.now().add(const Duration(days: 7)),
      location: 'Bordeaux',
      applicantUserIds: ['user_4'],
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Mission(
      id: 'mission_available_3',
      dossierId: 'dossier_available_3',
      title: 'Étude raccordement OSR556677',
      description:
          'Raccordement résidentiel standard. Maison individuelle avec installation standard, mission adaptée aux débutants.',
      status: MissionStatus.available,
      dateCreation: DateTime.now().subtract(const Duration(hours: 8)),
      requiredSkills: ['Électricité résidentielle', 'Visite technique'],
      estimatedDuration: 12,
      budgetEstime: 850.0,
      deadline: DateTime.now().add(const Duration(days: 14)),
      location: 'Toulouse',
      applicantUserIds: [],
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 8)),
    ),
  ];

  /// Récupère toutes les missions
  Future<List<Mission>> getAllMissions() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [..._missions, ..._availableMissions];
  }

  /// Récupère les missions assignées à un utilisateur
  Future<List<Mission>> getMissionsByUser(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _missions
        .where((mission) => mission.assignedUserId == userId)
        .toList();
  }

  /// Récupère les missions disponibles
  Future<List<Mission>> getAvailableMissions() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_availableMissions);
  }

  /// Récupère une mission par son ID
  Future<Mission?> getMissionById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return [
        ..._missions,
        ..._availableMissions,
      ].firstWhere((mission) => mission.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Crée une nouvelle mission
  Future<Mission> createMission(Mission mission) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final newMission = mission.copyWith(
      id: 'mission_${DateTime.now().millisecondsSinceEpoch}',
      dateCreation: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    if (mission.status == MissionStatus.available) {
      _availableMissions.add(newMission);
    } else {
      _missions.add(newMission);
    }

    return newMission;
  }

  /// Met à jour une mission
  Future<Mission> updateMission(Mission mission) async {
    await Future.delayed(const Duration(milliseconds: 600));

    // Chercher dans les missions assignées
    int index = _missions.indexWhere((m) => m.id == mission.id);
    if (index != -1) {
      final updatedMission = mission.copyWith(updatedAt: DateTime.now());
      _missions[index] = updatedMission;
      return updatedMission;
    }

    // Chercher dans les missions disponibles
    index = _availableMissions.indexWhere((m) => m.id == mission.id);
    if (index != -1) {
      final updatedMission = mission.copyWith(updatedAt: DateTime.now());
      _availableMissions[index] = updatedMission;
      return updatedMission;
    }

    throw Exception('Mission non trouvée');
  }

  /// Postule à une mission
  Future<Mission> applyToMission(String missionId, String userId) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final index = _availableMissions.indexWhere((m) => m.id == missionId);
    if (index != -1) {
      final mission = _availableMissions[index];
      if (!mission.applicantUserIds.contains(userId)) {
        final updatedMission = mission.addApplicant(userId);
        _availableMissions[index] = updatedMission;
        return updatedMission;
      }
      return mission;
    }

    throw Exception('Mission non trouvée');
  }

  /// Retire une candidature
  Future<Mission> withdrawApplication(String missionId, String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final index = _availableMissions.indexWhere((m) => m.id == missionId);
    if (index != -1) {
      final mission = _availableMissions[index];
      final updatedMission = mission.removeApplicant(userId);
      _availableMissions[index] = updatedMission;
      return updatedMission;
    }

    throw Exception('Mission non trouvée');
  }

  /// Assigne une mission à un utilisateur
  Future<Mission> assignMission(
    String missionId,
    String userId,
    String userName,
  ) async {
    await Future.delayed(const Duration(milliseconds: 700));

    final index = _availableMissions.indexWhere((m) => m.id == missionId);
    if (index != -1) {
      final mission = _availableMissions[index];
      final assignedMission = mission.assignTo(userId, userName);

      // Déplacer de disponible vers assignée
      _availableMissions.removeAt(index);
      _missions.add(assignedMission);

      return assignedMission;
    }

    throw Exception('Mission non trouvée');
  }

  /// Récupère les missions par statut
  Future<List<Mission>> getMissionsByStatus(MissionStatus status) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final allMissions = [..._missions, ..._availableMissions];
    return allMissions.where((mission) => mission.status == status).toList();
  }

  /// Récupère les missions en retard
  Future<List<Mission>> getOverdueMissions() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _missions.where((mission) => mission.isOverdue).toList();
  }

  /// Récupère les statistiques des missions
  Future<Map<String, dynamic>> getMissionStats(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final userMissions = _missions
        .where((m) => m.assignedUserId == userId)
        .toList();
    final available = _availableMissions.length;
    final inProgress = userMissions
        .where((m) => m.status == MissionStatus.inProgress)
        .length;
    final completed = userMissions
        .where((m) => m.status == MissionStatus.completed)
        .length;
    final overdue = userMissions.where((m) => m.isOverdue).length;

    final totalEarnings = userMissions.fold<double>(
      0.0,
      (sum, m) => sum + (m.budgetEstime ?? 0.0),
    );

    return {
      'total': userMissions.length,
      'available': available,
      'inProgress': inProgress,
      'completed': completed,
      'overdue': overdue,
      'totalEarnings': totalEarnings,
      'averageRating': 4.2, // Note moyenne simulée
    };
  }

  /// Supprime une mission
  Future<bool> deleteMission(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));

    int index = _missions.indexWhere((mission) => mission.id == id);
    if (index != -1) {
      _missions.removeAt(index);
      return true;
    }

    index = _availableMissions.indexWhere((mission) => mission.id == id);
    if (index != -1) {
      _availableMissions.removeAt(index);
      return true;
    }

    return false;
  }
}
