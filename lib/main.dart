import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Energy Smart Systems',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF3ADF7C), // Vert pro dynamique ESS
          secondary: Color(0xFF00B8D9), // Cyan technique ESS
          surface: Color(0xFF1A1A1A), // Surface composant ESS
          background: Color(0xFF0A0A0A), // Fond principal ESS
          error: Color(0xFFFF4D4F), // Alerte/erreur ESS
          onPrimary: Color(0xFF0A0A0A), // Texte sur vert = noir
          onSecondary: Color(0xFF0A0A0A), // Texte sur cyan = noir
          onSurface: Color(0xFFFFFFFF), // Texte principal blanc
          onBackground: Color(0xFFFFFFFF), // Texte sur fond = blanc
        ),
        scaffoldBackgroundColor: const Color(0xFF0A0A0A), // Fond ESS
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A1A1A), // Surface ESS
          foregroundColor: Color(0xFF3ADF7C), // Vert ESS
          elevation: 0,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF3ADF7C), // Vert ESS
          foregroundColor: Color(0xFF0A0A0A), // Noir sur vert
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1A1A1A), // Surface ESS
          selectedItemColor: Color(0xFF3ADF7C), // Vert ESS
          unselectedItemColor: Color(0xFFB0B0B0), // Gris secondaire ESS
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFFFFFFF)), // Blanc ESS
          bodyMedium: TextStyle(color: Color(0xFFB0B0B0)), // Gris ESS
          headlineMedium: TextStyle(
            color: Color(0xFF3ADF7C), // Vert ESS
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const MyHomePage(title: 'Energy Smart Systems'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _currentIndex = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Logo ESS stylisé avec les couleurs officielles
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF3ADF7C), // Vert ESS
                borderRadius: BorderRadius.circular(60),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3ADF7C).withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.bolt,
                size: 60,
                color: Color(0xFF0A0A0A), // Noir sur vert ESS
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Vous avez appuyé sur le bouton :',
              style: TextStyle(
                color: Color(0xFFB0B0B0), // Gris secondaire ESS
              ),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40),
            // Carte de démonstration avec style ESS
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A), // Surface ESS
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF3ADF7C), // Bordure verte ESS
                  width: 1,
                ),
              ),
              child: const Column(
                children: [
                  Text(
                    'Energy Smart Systems',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3ADF7C), // Vert ESS
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Solutions énergétiques intelligentes',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFB0B0B0), // Gris secondaire ESS
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Paramètres',
          ),
        ],
      ),
    );
  }
}
