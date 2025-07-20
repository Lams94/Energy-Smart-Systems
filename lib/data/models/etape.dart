import 'package:equatable/equatable.dart';

/// Énumération pour les types d'étapes
enum EtapeType {
  visiteReconnaissance('visite_reconnaissance', 'Visite de reconnaissance'),
  analyseExistant('analyse_existant', 'Analyse de l\'existant'),
  calculDimensionnement('calcul_dimensionnement', 'Calcul et dimensionnement'),
  redactionRapport('redaction_rapport', 'Rédaction du rapport'),
  verificationTechnique('verification_technique', 'Vérification technique'),
  validationClient('validation_client', 'Validation client'),
  facturation('facturation', 'Facturation');

  const EtapeType(this.value, this.label);
  final String value;
  final String label;

  static EtapeType fromString(String value) {
    return EtapeType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => EtapeType.visiteReconnaissance,
    );
  }

  /// Obtient l'ordre de l'étape dans le processus
  int get order {
    switch (this) {
      case EtapeType.visiteReconnaissance:
        return 1;
      case EtapeType.analyseExistant:
        return 2;
      case EtapeType.calculDimensionnement:
        return 3;
      case EtapeType.redactionRapport:
        return 4;
      case EtapeType.verificationTechnique:
        return 5;
      case EtapeType.validationClient:
        return 6;
      case EtapeType.facturation:
        return 7;
    }
  }
}

/// Énumération pour les statuts d'étape
enum EtapeStatus {
  notStarted('not_started', 'Non commencée'),
  inProgress('in_progress', 'En cours'),
  completed('completed', 'Terminée'),
  validated('validated', 'Validée'),
  rejected('rejected', 'Rejetée');

  const EtapeStatus(this.value, this.label);
  final String value;
  final String label;

  static EtapeStatus fromString(String value) {
    return EtapeStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => EtapeStatus.notStarted,
    );
  }
}

/// Modèle représentant une étape d'un dossier
class Etape extends Equatable {
  const Etape({
    required this.id,
    required this.dossierId,
    required this.type,
    required this.status,
    this.userId,
    this.userName,
    this.description,
    this.notes,
    this.documentsUrls = const [],
    this.coordonneesGPS,
    this.donneesTechniques,
    this.dateDebut,
    this.dateFin,
    this.dateValidation,
    this.tempsPasse,
    this.createdAt,
    this.updatedAt,
  });

  /// Identifiant unique de l'étape
  final String id;

  /// ID du dossier associé
  final String dossierId;

  /// Type d'étape
  final EtapeType type;

  /// Statut de l'étape
  final EtapeStatus status;

  /// ID de l'utilisateur responsable de l'étape
  final String? userId;

  /// Nom de l'utilisateur responsable (pour affichage)
  final String? userName;

  /// Description de l'étape
  final String? description;

  /// Notes et observations sur l'étape
  final String? notes;

  /// URLs des documents associés à l'étape
  final List<String> documentsUrls;

  /// Coordonnées GPS pour les étapes nécessitant une localisation
  final String? coordonneesGPS;

  /// Données techniques spécifiques à l'étape (JSON stringifié)
  final String? donneesTechniques;

  /// Date de début de l'étape
  final DateTime? dateDebut;

  /// Date de fin de l'étape
  final DateTime? dateFin;

  /// Date de validation de l'étape
  final DateTime? dateValidation;

  /// Temps passé sur l'étape en minutes
  final int? tempsPasse;

  /// Date de création de l'enregistrement
  final DateTime? createdAt;

  /// Date de dernière mise à jour
  final DateTime? updatedAt;

  /// Vérifie si l'étape est terminée
  bool get isCompleted =>
      status == EtapeStatus.completed || status == EtapeStatus.validated;

  /// Vérifie si l'étape est en cours
  bool get isInProgress => status == EtapeStatus.inProgress;

  /// Vérifie si l'étape nécessite une localisation GPS
  bool get requiresGPS => type == EtapeType.visiteReconnaissance;

  /// Vérifie si l'étape nécessite des données techniques
  bool get requiresTechnicalData =>
      type == EtapeType.analyseExistant ||
      type == EtapeType.calculDimensionnement;

  /// Durée de l'étape en heures
  double? get dureeEnHeures => tempsPasse != null ? tempsPasse! / 60.0 : null;

  @override
  List<Object?> get props => [
    id,
    dossierId,
    type,
    status,
    userId,
    userName,
    description,
    notes,
    documentsUrls,
    coordonneesGPS,
    donneesTechniques,
    dateDebut,
    dateFin,
    dateValidation,
    tempsPasse,
    createdAt,
    updatedAt,
  ];

  /// Crée une copie de l'étape avec des modifications
  Etape copyWith({
    String? id,
    String? dossierId,
    EtapeType? type,
    EtapeStatus? status,
    String? userId,
    String? userName,
    String? description,
    String? notes,
    List<String>? documentsUrls,
    String? coordonneesGPS,
    String? donneesTechniques,
    DateTime? dateDebut,
    DateTime? dateFin,
    DateTime? dateValidation,
    int? tempsPasse,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Etape(
      id: id ?? this.id,
      dossierId: dossierId ?? this.dossierId,
      type: type ?? this.type,
      status: status ?? this.status,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      description: description ?? this.description,
      notes: notes ?? this.notes,
      documentsUrls: documentsUrls ?? this.documentsUrls,
      coordonneesGPS: coordonneesGPS ?? this.coordonneesGPS,
      donneesTechniques: donneesTechniques ?? this.donneesTechniques,
      dateDebut: dateDebut ?? this.dateDebut,
      dateFin: dateFin ?? this.dateFin,
      dateValidation: dateValidation ?? this.dateValidation,
      tempsPasse: tempsPasse ?? this.tempsPasse,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Démarre l'étape
  Etape start(String userId, String userName) {
    return copyWith(
      status: EtapeStatus.inProgress,
      userId: userId,
      userName: userName,
      dateDebut: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  /// Termine l'étape
  Etape complete({String? notes, List<String>? documentsUrls}) {
    return copyWith(
      status: EtapeStatus.completed,
      dateFin: DateTime.now(),
      notes: notes ?? this.notes,
      documentsUrls: documentsUrls ?? this.documentsUrls,
      updatedAt: DateTime.now(),
    );
  }

  /// Valide l'étape
  Etape validate() {
    return copyWith(
      status: EtapeStatus.validated,
      dateValidation: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  /// Convertit l'étape en Map pour Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dossierId': dossierId,
      'type': type.value,
      'status': status.value,
      'userId': userId,
      'userName': userName,
      'description': description,
      'notes': notes,
      'documentsUrls': documentsUrls,
      'coordonneesGPS': coordonneesGPS,
      'donneesTechniques': donneesTechniques,
      'dateDebut': dateDebut?.toIso8601String(),
      'dateFin': dateFin?.toIso8601String(),
      'dateValidation': dateValidation?.toIso8601String(),
      'tempsPasse': tempsPasse,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// Crée une étape à partir d'une Map Firestore
  factory Etape.fromJson(Map<String, dynamic> json) {
    return Etape(
      id: json['id'] as String,
      dossierId: json['dossierId'] as String,
      type: EtapeType.fromString(json['type'] as String),
      status: EtapeStatus.fromString(json['status'] as String),
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      description: json['description'] as String?,
      notes: json['notes'] as String?,
      documentsUrls: List<String>.from(json['documentsUrls'] as List? ?? []),
      coordonneesGPS: json['coordonneesGPS'] as String?,
      donneesTechniques: json['donneesTechniques'] as String?,
      dateDebut: json['dateDebut'] != null
          ? DateTime.parse(json['dateDebut'] as String)
          : null,
      dateFin: json['dateFin'] != null
          ? DateTime.parse(json['dateFin'] as String)
          : null,
      dateValidation: json['dateValidation'] != null
          ? DateTime.parse(json['dateValidation'] as String)
          : null,
      tempsPasse: json['tempsPasse'] as int?,
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
    return 'Etape(id: $id, type: ${type.label}, status: ${status.label}, user: $userName)';
  }
}
