import 'package:equatable/equatable.dart';

/// Énumération pour les statuts de mission
enum MissionStatus {
  available('available', 'Disponible'),
  applied('applied', 'Candidature envoyée'),
  assigned('assigned', 'Attribuée'),
  inProgress('in_progress', 'En cours'),
  completed('completed', 'Terminée'),
  cancelled('cancelled', 'Annulée');

  const MissionStatus(this.value, this.label);
  final String value;
  final String label;

  static MissionStatus fromString(String value) {
    return MissionStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => MissionStatus.available,
    );
  }
}

/// Modèle représentant une mission (liée à un dossier)
class Mission extends Equatable {
  const Mission({
    required this.id,
    required this.dossierId,
    required this.title,
    required this.description,
    required this.status,
    required this.dateCreation,
    this.assignedUserId,
    this.assignedUserName,
    this.applicantUserIds = const [],
    this.requiredSkills = const [],
    this.estimatedDuration,
    this.budgetEstime,
    this.deadline,
    this.location,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  /// Identifiant unique de la mission
  final String id;

  /// ID du dossier associé
  final String dossierId;

  /// Titre de la mission
  final String title;

  /// Description détaillée de la mission
  final String description;

  /// Statut actuel de la mission
  final MissionStatus status;

  /// Date de création de la mission
  final DateTime dateCreation;

  /// ID de l'utilisateur assigné à la mission
  final String? assignedUserId;

  /// Nom de l'utilisateur assigné (pour affichage)
  final String? assignedUserName;

  /// Liste des IDs d'utilisateurs qui ont postulé
  final List<String> applicantUserIds;

  /// Compétences requises pour la mission
  final List<String> requiredSkills;

  /// Durée estimée en heures
  final int? estimatedDuration;

  /// Budget estimé pour la mission
  final double? budgetEstime;

  /// Date limite de la mission
  final DateTime? deadline;

  /// Localisation de la mission
  final String? location;

  /// Notes sur la mission
  final String? notes;

  /// Date de création de l'enregistrement
  final DateTime? createdAt;

  /// Date de dernière mise à jour
  final DateTime? updatedAt;

  /// Vérifie si la mission est disponible pour candidature
  bool get isAvailable => status == MissionStatus.available;

  /// Vérifie si la mission est assignée
  bool get isAssigned => assignedUserId != null;

  /// Vérifie si l'utilisateur a postulé à cette mission
  bool hasApplied(String userId) => applicantUserIds.contains(userId);

  /// Vérifie si la mission est en retard
  bool get isOverdue =>
      deadline != null &&
      DateTime.now().isAfter(deadline!) &&
      status != MissionStatus.completed;

  /// Nombre de candidatures reçues
  int get candidaturesCount => applicantUserIds.length;

  @override
  List<Object?> get props => [
    id,
    dossierId,
    title,
    description,
    status,
    dateCreation,
    assignedUserId,
    assignedUserName,
    applicantUserIds,
    requiredSkills,
    estimatedDuration,
    budgetEstime,
    deadline,
    location,
    notes,
    createdAt,
    updatedAt,
  ];

  /// Crée une copie de la mission avec des modifications
  Mission copyWith({
    String? id,
    String? dossierId,
    String? title,
    String? description,
    MissionStatus? status,
    DateTime? dateCreation,
    String? assignedUserId,
    String? assignedUserName,
    List<String>? applicantUserIds,
    List<String>? requiredSkills,
    int? estimatedDuration,
    double? budgetEstime,
    DateTime? deadline,
    String? location,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Mission(
      id: id ?? this.id,
      dossierId: dossierId ?? this.dossierId,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      dateCreation: dateCreation ?? this.dateCreation,
      assignedUserId: assignedUserId ?? this.assignedUserId,
      assignedUserName: assignedUserName ?? this.assignedUserName,
      applicantUserIds: applicantUserIds ?? this.applicantUserIds,
      requiredSkills: requiredSkills ?? this.requiredSkills,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      budgetEstime: budgetEstime ?? this.budgetEstime,
      deadline: deadline ?? this.deadline,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Ajoute un candidat à la mission
  Mission addApplicant(String userId) {
    if (applicantUserIds.contains(userId)) return this;

    return copyWith(
      applicantUserIds: [...applicantUserIds, userId],
      status: status == MissionStatus.available
          ? MissionStatus.applied
          : status,
      updatedAt: DateTime.now(),
    );
  }

  /// Retire un candidat de la mission
  Mission removeApplicant(String userId) {
    final newApplicants = applicantUserIds.where((id) => id != userId).toList();

    return copyWith(
      applicantUserIds: newApplicants,
      status: newApplicants.isEmpty && status == MissionStatus.applied
          ? MissionStatus.available
          : status,
      updatedAt: DateTime.now(),
    );
  }

  /// Assigne la mission à un utilisateur
  Mission assignTo(String userId, String userName) {
    return copyWith(
      assignedUserId: userId,
      assignedUserName: userName,
      status: MissionStatus.assigned,
      updatedAt: DateTime.now(),
    );
  }

  /// Convertit la mission en Map pour Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dossierId': dossierId,
      'title': title,
      'description': description,
      'status': status.value,
      'dateCreation': dateCreation.toIso8601String(),
      'assignedUserId': assignedUserId,
      'assignedUserName': assignedUserName,
      'applicantUserIds': applicantUserIds,
      'requiredSkills': requiredSkills,
      'estimatedDuration': estimatedDuration,
      'budgetEstime': budgetEstime,
      'deadline': deadline?.toIso8601String(),
      'location': location,
      'notes': notes,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// Crée une mission à partir d'une Map Firestore
  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      id: json['id'] as String,
      dossierId: json['dossierId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      status: MissionStatus.fromString(json['status'] as String),
      dateCreation: DateTime.parse(json['dateCreation'] as String),
      assignedUserId: json['assignedUserId'] as String?,
      assignedUserName: json['assignedUserName'] as String?,
      applicantUserIds: List<String>.from(
        json['applicantUserIds'] as List? ?? [],
      ),
      requiredSkills: List<String>.from(json['requiredSkills'] as List? ?? []),
      estimatedDuration: json['estimatedDuration'] as int?,
      budgetEstime: (json['budgetEstime'] as num?)?.toDouble(),
      deadline: json['deadline'] != null
          ? DateTime.parse(json['deadline'] as String)
          : null,
      location: json['location'] as String?,
      notes: json['notes'] as String?,
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
    return 'Mission(id: $id, title: $title, status: ${status.label}, candidatures: $candidaturesCount)';
  }
}
