import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_converter_app/src/app.dart';

void main() {
  testWidgets('App renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('HomeScreen has input fields', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.byType(TextField), findsNWidgets(2)); // Assuming two input fields
    expect(find.byType(ElevatedButton), findsOneWidget); // Assuming one button
  });

  testWidgets('SettingsScreen navigates correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final settingsButton = find.text('Settings');
    await tester.tap(settingsButton);
    await tester.pumpAndSettle();

    expect(find.byType(SettingsScreen), findsOneWidget);
  });
}