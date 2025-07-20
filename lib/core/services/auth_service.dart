import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/models.dart';

/// Service d'authentification
class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'current_user';
  static const String _isLoggedInKey = 'is_logged_in';

  /// Utilisateur actuellement connecté
  User? _currentUser;

  /// Statut de connexion
  bool _isLoggedIn = false;

  /// Getters
  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;

  /// Initialise le service d'authentification
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;

    if (_isLoggedIn) {
      final userData = prefs.getString(_userKey);
      if (userData != null) {
        try {
          // TODO: Désérialiser l'utilisateur depuis JSON
          // _currentUser = User.fromJson(jsonDecode(userData));
        } catch (e) {
          // En cas d'erreur, déconnecter l'utilisateur
          await logout();
        }
      }
    }
  }

  /// Connexion avec email et mot de passe
  Future<bool> login(String email, String password) async {
    try {
      // TODO: Implémenter l'authentification Firebase
      // Pour l'instant, simulation d'une connexion réussie
      await Future.delayed(const Duration(seconds: 1));

      // Créer un utilisateur de démonstration
      _currentUser = User(
        id: 'demo_user_123',
        email: email,
        firstName: 'John',
        lastName: 'Doe',
        role: email.contains('admin') ? UserRole.admin : UserRole.collaborator,
        department: 'Études techniques',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      _isLoggedIn = true;

      // Sauvegarder l'état de connexion
      await _saveAuthState();

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Déconnexion
  Future<void> logout() async {
    _currentUser = null;
    _isLoggedIn = false;

    // Nettoyer les données sauvegardées
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
    await prefs.remove(_isLoggedInKey);
  }

  /// Inscription (pour une future implémentation)
  Future<bool> register(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    try {
      // TODO: Implémenter l'inscription Firebase
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Réinitialisation du mot de passe
  Future<bool> resetPassword(String email) async {
    try {
      // TODO: Implémenter la réinitialisation Firebase
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Met à jour le profil utilisateur
  Future<bool> updateProfile(User updatedUser) async {
    try {
      // TODO: Implémenter la mise à jour Firebase
      _currentUser = updatedUser;
      await _saveAuthState();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Sauvegarde l'état d'authentification
  Future<void> _saveAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, _isLoggedIn);

    if (_currentUser != null) {
      // TODO: Sérialiser l'utilisateur en JSON
      // await prefs.setString(_userKey, jsonEncode(_currentUser!.toJson()));
    }
  }

  /// Vérifie si l'utilisateur est un administrateur
  bool get isAdmin => _currentUser?.isAdmin ?? false;

  /// Vérifie si l'utilisateur est un collaborateur
  bool get isCollaborator => _currentUser?.isCollaborator ?? false;
}
