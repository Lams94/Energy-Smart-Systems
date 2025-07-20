import 'package:flutter/foundation.dart';
import '../../data/models/models.dart';
import '../../data/repositories/dossier_repository.dart';

/// Provider pour la gestion des dossiers
class DossierProvider extends ChangeNotifier {
  final DossierRepository _repository = DossierRepository();

  List<Dossier> _dossiers = [];
  List<Dossier> _userDossiers = [];
  Map<String, dynamic> _stats = {};

  bool _isLoading = false;
  String? _error;

  /// Getters
  List<Dossier> get dossiers => List.unmodifiable(_dossiers);
  List<Dossier> get userDossiers => List.unmodifiable(_userDossiers);
  Map<String, dynamic> get stats => Map.unmodifiable(_stats);
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Charge tous les dossiers
  Future<void> loadAllDossiers() async {
    _setLoading(true);
    try {
      _dossiers = await _repository.getAllDossiers();
      _clearError();
    } catch (e) {
      _setError('Erreur lors du chargement des dossiers: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Charge les dossiers d'un utilisateur
  Future<void> loadUserDossiers(String userId) async {
    _setLoading(true);
    try {
      _userDossiers = await _repository.getDossiersByUser(userId);
      _clearError();
    } catch (e) {
      _setError('Erreur lors du chargement de vos dossiers: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Charge les statistiques
  Future<void> loadStats() async {
    try {
      _stats = await _repository.getDossierStats();
      _clearError();
    } catch (e) {
      _setError('Erreur lors du chargement des statistiques: $e');
    }
  }

  /// Crée un nouveau dossier
  Future<bool> createDossier(Dossier dossier) async {
    _setLoading(true);
    try {
      final newDossier = await _repository.createDossier(dossier);
      _dossiers.add(newDossier);
      _clearError();
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Erreur lors de la création du dossier: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Met à jour un dossier
  Future<bool> updateDossier(Dossier dossier) async {
    _setLoading(true);
    try {
      final updatedDossier = await _repository.updateDossier(dossier);

      // Mettre à jour dans la liste principale
      int index = _dossiers.indexWhere((d) => d.id == dossier.id);
      if (index != -1) {
        _dossiers[index] = updatedDossier;
      }

      // Mettre à jour dans les dossiers utilisateur
      index = _userDossiers.indexWhere((d) => d.id == dossier.id);
      if (index != -1) {
        _userDossiers[index] = updatedDossier;
      }

      _clearError();
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Erreur lors de la mise à jour du dossier: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Supprime un dossier
  Future<bool> deleteDossier(String dossierId) async {
    _setLoading(true);
    try {
      final success = await _repository.deleteDossier(dossierId);

      if (success) {
        _dossiers.removeWhere((d) => d.id == dossierId);
        _userDossiers.removeWhere((d) => d.id == dossierId);
        _clearError();
        notifyListeners();
        return true;
      }

      _setError('Dossier non trouvé');
      return false;
    } catch (e) {
      _setError('Erreur lors de la suppression: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Assigne un dossier à un utilisateur
  Future<bool> assignDossier(
    String dossierId,
    String userId,
    String userName,
  ) async {
    _setLoading(true);
    try {
      final updatedDossier = await _repository.assignDossier(
        dossierId,
        userId,
        userName,
      );

      // Mettre à jour dans la liste principale
      int index = _dossiers.indexWhere((d) => d.id == dossierId);
      if (index != -1) {
        _dossiers[index] = updatedDossier;
      }

      // Ajouter aux dossiers utilisateur si c'est le bon utilisateur
      if (userId == updatedDossier.assignedUserId) {
        _userDossiers.add(updatedDossier);
      }

      _clearError();
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Erreur lors de l\'assignation: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Récupère un dossier par ID
  Future<Dossier?> getDossierById(String id) async {
    try {
      return await _repository.getDossierById(id);
    } catch (e) {
      _setError('Erreur lors de la récupération du dossier: $e');
      return null;
    }
  }

  /// Récupère les dossiers par statut
  Future<List<Dossier>> getDossiersByStatus(DossierStatus status) async {
    try {
      return await _repository.getDossiersByStatus(status);
    } catch (e) {
      _setError('Erreur lors de la récupération des dossiers: $e');
      return [];
    }
  }

  /// Récupère les dossiers en retard
  Future<List<Dossier>> getOverdueDossiers() async {
    try {
      return await _repository.getOverdueDossiers();
    } catch (e) {
      _setError('Erreur lors de la récupération des dossiers en retard: $e');
      return [];
    }
  }

  /// Filtre les dossiers par statut
  List<Dossier> filterByStatus(DossierStatus status) {
    return _dossiers.where((dossier) => dossier.status == status).toList();
  }

  /// Filtre les dossiers par priorité
  List<Dossier> filterByPriority(DossierPriority priority) {
    return _dossiers.where((dossier) => dossier.priority == priority).toList();
  }

  /// Filtre les dossiers par département
  List<Dossier> filterByDepartment(String department) {
    return _dossiers
        .where(
          (dossier) => dossier.departement.toLowerCase().contains(
            department.toLowerCase(),
          ),
        )
        .toList();
  }

  /// Récupère les dossiers en retard (localement)
  List<Dossier> getLocalOverdueDossiers() {
    return _dossiers.where((dossier) => dossier.isOverdue).toList();
  }

  /// Récupère les dossiers urgents (échéance dans les 2 jours)
  List<Dossier> getUrgentDossiers() {
    final now = DateTime.now();
    return _dossiers.where((dossier) {
      final daysRemaining = dossier.dateLimiteRendu.difference(now).inDays;
      return daysRemaining >= 0 && daysRemaining <= 2;
    }).toList();
  }

  /// Recherche de dossiers
  List<Dossier> searchDossiers(String query) {
    final searchQuery = query.toLowerCase();
    return _dossiers
        .where(
          (dossier) =>
              dossier.numeroOSR.toLowerCase().contains(searchQuery) ||
              dossier.adresse.toLowerCase().contains(searchQuery) ||
              dossier.contactClient.toLowerCase().contains(searchQuery) ||
              dossier.natureDemande.toLowerCase().contains(searchQuery) ||
              dossier.departement.toLowerCase().contains(searchQuery),
        )
        .toList();
  }

  /// Actualise toutes les données
  Future<void> refresh(String userId) async {
    await Future.wait([
      loadAllDossiers(),
      loadUserDossiers(userId),
      loadStats(),
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
