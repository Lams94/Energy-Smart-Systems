// Constantes de l'application Energy Smart Systems

class AppConstants {
  // Informations de l'application
  static const String appName = 'Energy Smart Systems';
  static const String appVersion = '1.0.0';
  static const String appDescription =
      'Gestion des dossiers d\'étude de raccordement ENEDIS';

  // URLs et endpoints
  static const String baseUrl =
      'https://api.energysmart.com'; // À remplacer par l'URL réelle
  static const String apiVersion = 'v1';

  // Configuration Firebase
  static const String firebaseProjectId = 'energy-smart-systems'; // À remplacer

  // Délais et timeouts
  static const int networkTimeout = 30; // secondes
  static const int autoAssignmentDelay = 24; // heures
  static const int reminderDelay = 48; // heures avant échéance

  // Limites métier
  static const int maxMissionsPerUser = 5;
  static const int minMissionsForBonus = 10;
  static const double minRatingForBonus = 4.5;
  static const int maxConsecutiveRefusals = 3;

  // Types de fichiers autorisés
  static const List<String> allowedImageExtensions = [
    'jpg',
    'jpeg',
    'png',
    'webp',
  ];
  static const List<String> allowedDocumentExtensions = ['pdf', 'doc', 'docx'];
  static const int maxFileSizeMB = 10;

  // Types de notifications
  static const String notificationNewMission = 'new_mission';
  static const String notificationReminder = 'reminder';
  static const String notificationAssignment = 'assignment';
  static const String notificationSuspension = 'suspension';

  // Clés de stockage local
  static const String keyAuthToken = 'auth_token';
  static const String keyUserProfile = 'user_profile';
  static const String keyNotificationSettings = 'notification_settings';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';

  // Routes de navigation
  static const String routeHome = '/';
  static const String routeLogin = '/login';
  static const String routeRegister = '/register';
  static const String routeProfile = '/profile';
  static const String routeMissions = '/missions';
  static const String routeMissionDetail = '/missions/:id';
  static const String routeAdmin = '/admin';
  static const String routeSettings = '/settings';
  static const String routeNotifications = '/notifications';
  static const String routeReports = '/reports';
}

/// Routes de navigation de l'application
class AppRoutes {
  // Routes d'authentification
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // Routes principales
  static const String splash = '/';
  static const String dashboard = '/dashboard';
  static const String profile = '/profile';

  // Routes des dossiers
  static const String dossiers = '/dossiers';
  static const String dossierDetail = '/dossiers/:id';
  static const String createDossier = '/dossiers/create';

  // Routes des missions
  static const String missions = '/missions';
  static const String missionDetail = '/missions/:id';
  static const String availableMissions = '/missions/available';
  static const String myMissions = '/missions/my';

  // Routes des étapes
  static const String etapes = '/etapes';
  static const String etapeDetail = '/etapes/:id';

  // Routes administrateur
  static const String admin = '/admin';
  static const String adminUsers = '/admin/users';
  static const String adminReports = '/admin/reports';
  static const String adminSettings = '/admin/settings';

  // Routes utilitaires
  static const String settings = '/settings';
  static const String about = '/about';
  static const String help = '/help';

  /// Génère une route avec paramètres
  static String dossierDetailWithId(String id) => '/dossiers/$id';
  static String missionDetailWithId(String id) => '/missions/$id';
  static String etapeDetailWithId(String id) => '/etapes/$id';
}

// Types énumérés
enum UserRole { admin, collaborator }

enum MissionStatus {
  available,
  assigned,
  inProgress,
  completed,
  overdue,
  cancelled,
}

enum MissionStep {
  studyInProgress,
  technicalVisit,
  reportWritten,
  fssReceived,
  invoiceValidated,
  paymentReceived,
}

enum NotificationType {
  newMission,
  reminder,
  assignment,
  suspension,
  statusUpdate,
}

enum FileType { image, document, report }

// Extensions pour les énumérés
extension UserRoleExtension on UserRole {
  String get name {
    switch (this) {
      case UserRole.admin:
        return 'Administrateur';
      case UserRole.collaborator:
        return 'Collaborateur';
    }
  }

  String get code {
    switch (this) {
      case UserRole.admin:
        return 'admin';
      case UserRole.collaborator:
        return 'collaborateur';
    }
  }
}

extension MissionStatusExtension on MissionStatus {
  String get name {
    switch (this) {
      case MissionStatus.available:
        return 'Disponible';
      case MissionStatus.assigned:
        return 'Attribuée';
      case MissionStatus.inProgress:
        return 'En cours';
      case MissionStatus.completed:
        return 'Terminée';
      case MissionStatus.overdue:
        return 'En retard';
      case MissionStatus.cancelled:
        return 'Annulée';
    }
  }

  String get code {
    switch (this) {
      case MissionStatus.available:
        return 'disponible';
      case MissionStatus.assigned:
        return 'attribuee';
      case MissionStatus.inProgress:
        return 'en_cours';
      case MissionStatus.completed:
        return 'terminee';
      case MissionStatus.overdue:
        return 'en_retard';
      case MissionStatus.cancelled:
        return 'annulee';
    }
  }
}

extension MissionStepExtension on MissionStep {
  String get name {
    switch (this) {
      case MissionStep.studyInProgress:
        return 'Étude en cours';
      case MissionStep.technicalVisit:
        return 'Visite technique';
      case MissionStep.reportWritten:
        return 'Rapport rédigé';
      case MissionStep.fssReceived:
        return 'FSS reçu';
      case MissionStep.invoiceValidated:
        return 'Facturation validée';
      case MissionStep.paymentReceived:
        return 'Paiement reçu';
    }
  }

  String get code {
    switch (this) {
      case MissionStep.studyInProgress:
        return 'etude_en_cours';
      case MissionStep.technicalVisit:
        return 'visite_technique';
      case MissionStep.reportWritten:
        return 'rapport_redige';
      case MissionStep.fssReceived:
        return 'fss_recu';
      case MissionStep.invoiceValidated:
        return 'facturation_validee';
      case MissionStep.paymentReceived:
        return 'paiement_recu';
    }
  }
}
