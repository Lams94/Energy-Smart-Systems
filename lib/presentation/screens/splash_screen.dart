import 'package:flutter/material.dart';
import '../widgets/logo_ess.dart';
import '../../core/constants/app_colors.dart';
import 'home_screen_ess.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> 
    with TickerProviderStateMixin {
  
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  
  @override
  void initState() {
    super.initState();
    
    // Contrôleur pour l'animation de fade
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    // Contrôleur pour l'animation de scale
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    // Animation de fade
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
    
    // Animation de scale
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));
    
    // Démarrer les animations
    _startAnimations();
    
    // Navigation vers l'écran principal après 3 secondes
    _navigateToHome();
  }
  
  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _scaleController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _fadeController.forward();
  }
  
  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const HomeScreenEss(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    }
  }
  
  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.background,
              AppColors.surface,
              AppColors.background,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              
              // Logo ESS animé
              AnimatedBuilder(
                animation: Listenable.merge([_fadeController, _scaleController]),
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          // Logo principal
                          const LogoEss.large(),
                          
                          const SizedBox(height: 30),
                          
                          // Nom de l'application
                          Text(
                            'Energy Smart Systems',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              letterSpacing: 1.2,
                            ),
                          ),
                          
                          const SizedBox(height: 10),
                          
                          // Slogan
                          Text(
                            'Solutions énergétiques intelligentes',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              
              const Spacer(flex: 2),
              
              // Indicateur de chargement
              FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    Text(
                      'Initialisation...',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
