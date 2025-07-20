import 'package:flutter/foundation.dart';
import '../../core/services/auth_service.dart';
import '../../data/models/models.dart';

/// Provider pour la gestion de l'authentification
class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _error;

  /// Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _authService.isLoggedIn;
  User? get currentUser => _authService.currentUser;
  bool get isAdmin => _authService.isAdmin;
  bool get isCollaborator => _authService.isCollaborator;

  /// Initialise le provider
  Future<void> initialize() async {
    _setLoading(true);
    try {
      await _authService.initialize();
      _clearError();
    } catch (e) {
      _setError('Erreur lors de l\'initialisation: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Connexion
  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      final success = await _authService.login(email, password);
      if (success) {
        _clearError();
        notifyListeners();
        return true;
      } else {
        _setError('Email ou mot de passe incorrect');
        return false;
      }
    } catch (e) {
      _setError('Erreur lors de la connexion: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Déconnexion
  Future<void> logout() async {
    _setLoading(true);
    try {
      await _authService.logout();
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Erreur lors de la déconnexion: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Inscription
  Future<bool> register(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    _setLoading(true);
    _clearError();

    try {
      final success = await _authService.register(
        email,
        password,
        firstName,
        lastName,
      );
      if (success) {
        _clearError();
        notifyListeners();
        return true;
      } else {
        _setError('Erreur lors de l\'inscription');
        return false;
      }
    } catch (e) {
      _setError('Erreur lors de l\'inscription: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Réinitialisation du mot de passe
  Future<bool> resetPassword(String email) async {
    _setLoading(true);
    _clearError();

    try {
      final success = await _authService.resetPassword(email);
      if (success) {
        _clearError();
        return true;
      } else {
        _setError('Erreur lors de la réinitialisation');
        return false;
      }
    } catch (e) {
      _setError('Erreur lors de la réinitialisation: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Met à jour le profil
  Future<bool> updateProfile(User updatedUser) async {
    _setLoading(true);
    _clearError();

    try {
      final success = await _authService.updateProfile(updatedUser);
      if (success) {
        _clearError();
        notifyListeners();
        return true;
      } else {
        _setError('Erreur lors de la mise à jour du profil');
        return false;
      }
    } catch (e) {
      _setError('Erreur lors de la mise à jour: $e');
      return false;
    } finally {
      _setLoading(false);
    }
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
