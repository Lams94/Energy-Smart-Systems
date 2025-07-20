import 'package:equatable/equatable.dart';

/// Énumération pour les rôles d'utilisateur
enum UserRole {
  admin('admin'),
  collaborator('collaborator');

  const UserRole(this.value);
  final String value;

  static UserRole fromString(String value) {
    return UserRole.values.firstWhere(
      (role) => role.value == value,
      orElse: () => UserRole.collaborator,
    );
  }
}

/// Modèle représentant un utilisateur de l'application
class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    this.phone,
    this.department,
    this.isActive = true,
    this.profileImageUrl,
    this.createdAt,
    this.updatedAt,
  });

  /// Identifiant unique de l'utilisateur
  final String id;

  /// Email de l'utilisateur (utilisé pour l'authentification)
  final String email;

  /// Prénom de l'utilisateur
  final String firstName;

  /// Nom de famille de l'utilisateur
  final String lastName;

  /// Rôle de l'utilisateur (admin ou collaborateur)
  final UserRole role;

  /// Numéro de téléphone (optionnel)
  final String? phone;

  /// Département de rattachement
  final String? department;

  /// Statut actif/inactif de l'utilisateur
  final bool isActive;

  /// URL de l'image de profil
  final String? profileImageUrl;

  /// Date de création du compte
  final DateTime? createdAt;

  /// Date de dernière mise à jour
  final DateTime? updatedAt;

  /// Nom complet de l'utilisateur
  String get fullName => '$firstName $lastName';

  /// Vérifie si l'utilisateur est un administrateur
  bool get isAdmin => role == UserRole.admin;

  /// Vérifie si l'utilisateur est un collaborateur
  bool get isCollaborator => role == UserRole.collaborator;

  @override
  List<Object?> get props => [
    id,
    email,
    firstName,
    lastName,
    role,
    phone,
    department,
    isActive,
    profileImageUrl,
    createdAt,
    updatedAt,
  ];

  /// Crée une copie de l'utilisateur avec des modifications
  User copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    UserRole? role,
    String? phone,
    String? department,
    bool? isActive,
    String? profileImageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      department: department ?? this.department,
      isActive: isActive ?? this.isActive,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Convertit l'utilisateur en Map pour Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'role': role.value,
      'phone': phone,
      'department': department,
      'isActive': isActive,
      'profileImageUrl': profileImageUrl,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// Crée un utilisateur à partir d'une Map Firestore
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      role: UserRole.fromString(json['role'] as String),
      phone: json['phone'] as String?,
      department: json['department'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      profileImageUrl: json['profileImageUrl'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, fullName: $fullName, role: ${role.value})';
  }
}
