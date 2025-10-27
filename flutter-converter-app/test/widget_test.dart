import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_converter_app/screens/home_screen.dart';
import 'package:flutter_converter_app/screens/converter_screen.dart';

void main() {
  testWidgets('HomeScreen has a title and navigates to ConverterScreen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    expect(find.text('Flutter Converter'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.byType(ConverterScreen), findsOneWidget);
  });

  testWidgets('ConverterScreen shows unit selector and result display', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ConverterScreen()));

    expect(find.byType(UnitSelector), findsOneWidget);
    expect(find.byType(ResultDisplay), findsOneWidget);
  });
}