// Test basique pour l'application Energy Smart Systems
//
// Pour exécuter ce test, utilisez : flutter test

import 'package:flutter_test/flutter_test.dart';

import 'package:energy_smart_systems/main.dart';

void main() {
  testWidgets('Application se lance correctement', (WidgetTester tester) async {
    // Lance l'application
    await tester.pumpWidget(const EnergySmartSystemsApp());

    // Attend que l'application soit entièrement chargée
    await tester.pumpAndSettle();

    // Vérifie que l'écran de connexion est affiché
    expect(find.text('Energy Smart Systems'), findsOneWidget);
  });
}
