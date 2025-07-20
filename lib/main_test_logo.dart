import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/app_colors.dart';
import 'presentation/widgets/logo_ess.dart';
import 'presentation/screens/home_screen_ess.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Configuration de la barre de statut
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0A0A0A),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const EnergySmartSystemsApp());
}

class EnergySmartSystemsApp extends StatelessWidget {
  const EnergySmartSystemsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: LogoTestScreen(),
    );
  }
}

/// Écran de test temporaire pour vérifier le logo ESS
class LogoTestScreen extends StatefulWidget {
  @override
  State<LogoTestScreen> createState() => _LogoTestScreenState();
}

class _LogoTestScreenState extends State<LogoTestScreen> {
  bool _showHomeScreen = false;

  @override
  void initState() {
    super.initState();
    // Afficher l'écran de test pendant 3 secondes, puis basculer
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showHomeScreen = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showHomeScreen) {
      return const HomeScreenEss();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Test du splash logo animé
              SplashLogoEss(
                subtitle: "Test Logo ESS",
                animate: true,
              ),
              
              const SizedBox(height: 40),
              
              // Test des différentes tailles de logo
              Text(
                'Tests des logos ESS',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              
              const SizedBox(height: 20),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      LogoEss.small(),
                      const SizedBox(height: 8),
                      Text(
                        'Small',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      LogoEss.medium(),
                      const SizedBox(height: 8),
                      Text(
                        'Medium',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      LogoEss(),
                      const SizedBox(height: 8),
                      Text(
                        'Default',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 40),
              
              // Test de chargement avec logo
              LoadingEss(
                message: "Chargement ESS...",
                logoSize: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
