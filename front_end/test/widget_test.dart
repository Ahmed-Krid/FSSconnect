import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:front_end/main.dart';

void main() {
  testWidgets('Navigation bar test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify that the navigation bar is present
    expect(find.byType(BottomNavigationBar), findsOneWidget);

    // Verify that all navigation items are present
    expect(find.text('Calendrier'), findsOneWidget);
    expect(find.text('Fiche des notes'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Emploi du temps'), findsOneWidget);
    expect(find.text('Cours'), findsOneWidget);

    // Test navigation item tapping
    // Initially Home (index 2) should be selected
    expect(find.text('Selected index: 2'), findsOneWidget);

    // Tap on Calendrier (index 0)
    await tester.tap(find.text('Calendrier'));
    await tester.pump();
    expect(find.text('Selected index: 0'), findsOneWidget);

    // Tap on Cours (index 4)
    await tester.tap(find.text('Cours'));
    await tester.pump();
    expect(find.text('Selected index: 4'), findsOneWidget);
  });

}
