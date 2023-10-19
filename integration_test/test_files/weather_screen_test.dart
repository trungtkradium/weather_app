import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:weather_app/src/presentation/res/keys.dart';

import '../app_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Test Search Weather by keyword', (tester) async {
    final app = await appTest();
    await tester.pumpWidget(app);

    final textField = find.byKey(Key(Keys.searchTextField));
    final weatherInformation = find.byKey(Key(Keys.weatherInformation));
    final searchButton = find.byKey(Key(Keys.searchButton));
    expect(weatherInformation, findsNothing);
    expect(textField, findsOneWidget);

    await tester.enterText(textField, 'Viet Nam');
    await tester.tap(searchButton);
    await tester.pumpAndSettle();

    expect(weatherInformation, findsOneWidget);
  });

  testWidgets('Test Search Weather by zipcode', (tester) async {
    final app = await appTest();
    await tester.pumpWidget(app);

    final textField = find.byKey(Key(Keys.searchTextField));
    final weatherInformation = find.byKey(Key(Keys.weatherInformation));
    final searchButton = find.byKey(Key(Keys.searchButton));
    expect(weatherInformation, findsNothing);
    expect(textField, findsOneWidget);

    await tester.enterText(textField, '90210');
    await tester.tap(searchButton);
    await tester.pumpAndSettle();

    expect(weatherInformation, findsOneWidget);
  });
}
