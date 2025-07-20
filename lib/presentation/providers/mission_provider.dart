import 'package:flutter/foundation.dart';
import '../../data/models/models.dart';
import '../../data/repositories/mission_repository.dart';

/// Provider pour la gestion des missions
class MissionProvider extends ChangeNotifier {
  final MissionRepository _repository = MissionRepository();

  List<Mission> _missions = [];
  List<Mission> _availableMissions = [];
  List<Mission> _userMissions = [];
  Map<String, dynamic> _stats = {};

  bool _isLoading = false;
  String? _error;

  /// Getters
  List<Mission> get missions => List.unmodifiable(_missions);
  List<Mission> get availableMissions => List.unmodifiable(_availableMissions);
  List<Mission> get userMissions => List.unmodifiable(_userMissions);
  Map<String, dynamic> get stats => Map.unmodifiable(_stats);
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Charge toutes les missions
  Future<void> loadAllMissions() async {
    _setLoading(true);
    try {
      _missions = await _repository.getAllMissions();
      _clearError();
    } catch (e) {
      _setError('Erreur lors du chargement des missions: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Charge les missions disponibles
  Future<void> loadAvailableMissions() async {
    _setLoading(true);
    try {
      _availableMissions = await _repository.getAvailableMissions();
      _clearError();
    } catch (e) {
      _setError('Erreur lors du chargement des missions disponibles: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Charge les missions d'un utilisateur
  Future<void> loadUserMissions(String userId) async {
    _setLoading(true);
    try {
      _userMissions = await _repository.getMissionsByUser(userId);
      _clearError();
    } catch (e) {
      _setError('Erreur lors du chargement de vos missions: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Charge les statistiques
  Future<void> loadStats(String userId) async {
    try {
      _stats = await _repository.getMissionStats(userId);
      _clearError();
    } catch (e) {
      _setError('Erreur lors du chargement des statistiques: $e');
    }
  }

  /// Postule à une mission
  Future<bool> applyToMission(String missionId, String userId) async {
    _setLoading(true);
    try {
      final updatedMission = await _repository.applyToMission(
        missionId,
        userId,
      );

      // Mettre à jour la mission dans la liste
      final index = _availableMissions.indexWhere((m) => m.id == missionId);
      if (index != -1) {
        _availableMissions[index] = updatedMission;
      }

      _clearError();
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Erreur lors de la candidature: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Retire une candidature
  Future<bool> withdrawApplication(String missionId, String userId) async {
    _setLoading(true);
    try {
      final updatedMission = await _repository.withdrawApplication(
        missionId,
        userId,
      );

      // Mettre à jour la mission dans la liste
      final index = _availableMissions.indexWhere((m) => m.id == missionId);
      if (index != -1) {
        _availableMissions[index] = updatedMission;
      }

      _clearError();
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Erreur lors du retrait de candidature: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Crée une nouvelle mission
  Future<bool> createMission(Mission mission) async {
    _setLoading(true);
    try {
      final newMission = await _repository.createMission(mission);

      if (newMission.status == MissionStatus.available) {
        _availableMissions.add(newMission);
      } else {
        _missions.add(newMission);
      }

      _clearError();
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Erreur lors de la création de la mission: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Met à jour une mission
  Future<bool> updateMission(Mission mission) async {
    _setLoading(true);
    try {
      final updatedMission = await _repository.updateMission(mission);

      // Mettre à jour dans la liste appropriée
      int index = _missions.indexWhere((m) => m.id == mission.id);
      if (index != -1) {
        _missions[index] = updatedMission;
      } else {
        index = _availableMissions.indexWhere((m) => m.id == mission.id);
        if (index != -1) {
          _availableMissions[index] = updatedMission;
        }
      }

      // Mettre à jour les missions utilisateur si nécessaire
      index = _userMissions.indexWhere((m) => m.id == mission.id);
      if (index != -1) {
        _userMissions[index] = updatedMission;
      }

      _clearError();
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Erreur lors de la mise à jour de la mission: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Supprime une mission
  Future<bool> deleteMission(String missionId) async {
    _setLoading(true);
    try {
      final success = await _repository.deleteMission(missionId);

      if (success) {
        _missions.removeWhere((m) => m.id == missionId);
        _availableMissions.removeWhere((m) => m.id == missionId);
        _userMissions.removeWhere((m) => m.id == missionId);
        _clearError();
        notifyListeners();
        return true;
      }

      _setError('Mission non trouvée');
      return false;
    } catch (e) {
      _setError('Erreur lors de la suppression: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Récupère une mission par ID
  Future<Mission?> getMissionById(String id) async {
    try {
      return await _repository.getMissionById(id);
    } catch (e) {
      _setError('Erreur lors de la récupération de la mission: $e');
      return null;
    }
  }

  /// Récupère les missions en retard
  Future<List<Mission>> getOverdueMissions() async {
    try {
      return await _repository.getOverdueMissions();
    } catch (e) {
      _setError('Erreur lors de la récupération des missions en retard: $e');
      return [];
    }
  }

  /// Filtre les missions par statut
  List<Mission> filterByStatus(MissionStatus status) {
    return _missions.where((mission) => mission.status == status).toList();
  }

  /// Filtre les missions par compétence
  List<Mission> filterBySkill(String skill) {
    return _availableMissions
        .where(
          (mission) => mission.requiredSkills.any(
            (s) => s.toLowerCase().contains(skill.toLowerCase()),
          ),
        )
        .toList();
  }

  /// Recherche de missions
  List<Mission> searchMissions(String query) {
    final searchQuery = query.toLowerCase();
    return _availableMissions
        .where(
          (mission) =>
              mission.title.toLowerCase().contains(searchQuery) ||
              mission.description.toLowerCase().contains(searchQuery) ||
              mission.location?.toLowerCase().contains(searchQuery) == true ||
              mission.requiredSkills.any(
                (skill) => skill.toLowerCase().contains(searchQuery),
              ),
        )
        .toList();
  }

  /// Actualise toutes les données
  Future<void> refresh(String userId) async {
    await Future.wait([
      loadAvailableMissions(),
      loadUserMissions(userId),
      loadStats(userId),
    ]);
  }

  /// Méthodes utilitaires privées
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }

  /// Nettoie l'erreur
  void clearError() {
    _clearError();
  }
}
