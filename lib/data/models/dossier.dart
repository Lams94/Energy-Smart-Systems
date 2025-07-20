import 'package:equatable/equatable.dart';

/// Énumération pour les statuts de dossier
enum DossierStatus {
  pending('pending', 'En attente'),
  assigned('assigned', 'Attribué'),
  inProgress('in_progress', 'En cours'),
  completed('completed', 'Terminé'),
  validated('validated', 'Validé'),
  billed('billed', 'Facturé');

  const DossierStatus(this.value, this.label);
  final String value;
  final String label;

  static DossierStatus fromString(String value) {
    return DossierStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => DossierStatus.pending,
    );
  }
}

/// Énumération pour les priorités de dossier
enum DossierPriority {
  low('low', 'Faible'),
  medium('medium', 'Moyenne'),
  high('high', 'Élevée'),
  urgent('urgent', 'Urgente');

  const DossierPriority(this.value, this.label);
  final String value;
  final String label;

  static DossierPriority fromString(String value) {
    return DossierPriority.values.firstWhere(
      (priority) => priority.value == value,
      orElse: () => DossierPriority.medium,
    );
  }
}

/// Modèle représentant un dossier d'étude ENEDIS
class Dossier extends Equatable {
  const Dossier({
    required this.id,
    required this.numeroOSR,
    required this.adresse,
    required this.departement,
    required this.contactClient,
    required this.natureDemande,
    required this.dateLimiteRendu,
    required this.status,
    this.assignedUserId,
    this.assignedUserName,
    this.solutionEnedis,
    this.priority = DossierPriority.medium,
    this.montantEstime,
    this.montantFacture,
    this.dateCreation,
    this.dateAssignation,
    this.dateCompletion,
    this.notes,
    this.documentsUrls = const [],
    this.etapesCompletees = const [],
    this.createdAt,
    this.updatedAt,
  });

  /// Identifiant unique du dossier
  final String id;

  /// Numéro OSR fourni par ENEDIS
  final String numeroOSR;

  /// Adresse complète de l'installation
  final String adresse;

  /// Département (code postal ou nom)
  final String departement;

  /// Informations de contact du client
  final String contactClient;

  /// Nature de la demande de raccordement
  final String natureDemande;

  /// Date limite de rendu du dossier
  final DateTime dateLimiteRendu;

  /// Statut actuel du dossier
  final DossierStatus status;

  /// ID de l'utilisateur assigné au dossier
  final String? assignedUserId;

  /// Nom de l'utilisateur assigné (pour affichage)
  final String? assignedUserName;

  /// Solution ENEDIS envisagée
  final String? solutionEnedis;

  /// Priorité du dossier
  final DossierPriority priority;

  /// Montant estimé du dossier
  final double? montantEstime;

  /// Montant facturé final
  final double? montantFacture;

  /// Date de création du dossier
  final DateTime? dateCreation;

  /// Date d'assignation du dossier
  final DateTime? dateAssignation;

  /// Date de completion du dossier
  final DateTime? dateCompletion;

  /// Notes et commentaires sur le dossier
  final String? notes;

  /// URLs des documents joints
  final List<String> documentsUrls;

  /// Liste des étapes completées
  final List<String> etapesCompletees;

  /// Date de création de l'enregistrement
  final DateTime? createdAt;

  /// Date de dernière mise à jour
  final DateTime? updatedAt;

  /// Vérifie si le dossier est assigné
  bool get isAssigned => assignedUserId != null;

  /// Vérifie si le dossier est en retard
  bool get isOverdue =>
      DateTime.now().isAfter(dateLimiteRendu) &&
      status != DossierStatus.completed &&
      status != DossierStatus.validated &&
      status != DossierStatus.billed;

  /// Calcul du pourcentage de completion
  double get completionPercentage {
    const totalEtapes = 7; // Basé sur les 7 étapes définies dans les specs
    return etapesCompletees.length / totalEtapes;
  }

  /// Nombre de jours restants
  int get joursRestants {
    final maintenant = DateTime.now();
    final difference = dateLimiteRendu.difference(maintenant).inDays;
    return difference;
  }

  @override
  List<Object?> get props => [
    id,
    numeroOSR,
    adresse,
    departement,
    contactClient,
    natureDemande,
    dateLimiteRendu,
    status,
    assignedUserId,
    assignedUserName,
    solutionEnedis,
    priority,
    montantEstime,
    montantFacture,
    dateCreation,
    dateAssignation,
    dateCompletion,
    notes,
    documentsUrls,
    etapesCompletees,
    createdAt,
    updatedAt,
  ];

  /// Crée une copie du dossier avec des modifications
  Dossier copyWith({
    String? id,
    String? numeroOSR,
    String? adresse,
    String? departement,
    String? contactClient,
    String? natureDemande,
    DateTime? dateLimiteRendu,
    DossierStatus? status,
    String? assignedUserId,
    String? assignedUserName,
    String? solutionEnedis,
    DossierPriority? priority,
    double? montantEstime,
    double? montantFacture,
    DateTime? dateCreation,
    DateTime? dateAssignation,
    DateTime? dateCompletion,
    String? notes,
    List<String>? documentsUrls,
    List<String>? etapesCompletees,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Dossier(
      id: id ?? this.id,
      numeroOSR: numeroOSR ?? this.numeroOSR,
      adresse: adresse ?? this.adresse,
      departement: departement ?? this.departement,
      contactClient: contactClient ?? this.contactClient,
      natureDemande: natureDemande ?? this.natureDemande,
      dateLimiteRendu: dateLimiteRendu ?? this.dateLimiteRendu,
      status: status ?? this.status,
      assignedUserId: assignedUserId ?? this.assignedUserId,
      assignedUserName: assignedUserName ?? this.assignedUserName,
      solutionEnedis: solutionEnedis ?? this.solutionEnedis,
      priority: priority ?? this.priority,
      montantEstime: montantEstime ?? this.montantEstime,
      montantFacture: montantFacture ?? this.montantFacture,
      dateCreation: dateCreation ?? this.dateCreation,
      dateAssignation: dateAssignation ?? this.dateAssignation,
      dateCompletion: dateCompletion ?? this.dateCompletion,
      notes: notes ?? this.notes,
      documentsUrls: documentsUrls ?? this.documentsUrls,
      etapesCompletees: etapesCompletees ?? this.etapesCompletees,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Convertit le dossier en Map pour Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numeroOSR': numeroOSR,
      'adresse': adresse,
      'departement': departement,
      'contactClient': contactClient,
      'natureDemande': natureDemande,
      'dateLimiteRendu': dateLimiteRendu.toIso8601String(),
      'status': status.value,
      'assignedUserId': assignedUserId,
      'assignedUserName': assignedUserName,
      'solutionEnedis': solutionEnedis,
      'priority': priority.value,
      'montantEstime': montantEstime,
      'montantFacture': montantFacture,
      'dateCreation': dateCreation?.toIso8601String(),
      'dateAssignation': dateAssignation?.toIso8601String(),
      'dateCompletion': dateCompletion?.toIso8601String(),
      'notes': notes,
      'documentsUrls': documentsUrls,
      'etapesCompletees': etapesCompletees,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// Crée un dossier à partir d'une Map Firestore
  factory Dossier.fromJson(Map<String, dynamic> json) {
    return Dossier(
      id: json['id'] as String,
      numeroOSR: json['numeroOSR'] as String,
      adresse: json['adresse'] as String,
      departement: json['departement'] as String,
      contactClient: json['contactClient'] as String,
      natureDemande: json['natureDemande'] as String,
      dateLimiteRendu: DateTime.parse(json['dateLimiteRendu'] as String),
      status: DossierStatus.fromString(json['status'] as String),
      assignedUserId: json['assignedUserId'] as String?,
      assignedUserName: json['assignedUserName'] as String?,
      solutionEnedis: json['solutionEnedis'] as String?,
      priority: DossierPriority.fromString(
        json['priority'] as String? ?? 'medium',
      ),
      montantEstime: (json['montantEstime'] as num?)?.toDouble(),
      montantFacture: (json['montantFacture'] as num?)?.toDouble(),
      dateCreation: json['dateCreation'] != null
          ? DateTime.parse(json['dateCreation'] as String)
          : null,
      dateAssignation: json['dateAssignation'] != null
          ? DateTime.parse(json['dateAssignation'] as String)
          : null,
      dateCompletion: json['dateCompletion'] != null
          ? DateTime.parse(json['dateCompletion'] as String)
          : null,
      notes: json['notes'] as String?,
      documentsUrls: List<String>.from(json['documentsUrls'] as List? ?? []),
      etapesCompletees: List<String>.from(
        json['etapesCompletees'] as List? ?? [],
      ),
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
    return 'Dossier(id: $id, numeroOSR: $numeroOSR, status: ${status.label}, assigné: $assignedUserName)';
  }
}
