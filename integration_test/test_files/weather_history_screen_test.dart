import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:weather_app/src/presentation/components/weather_information.dart';
import 'package:weather_app/src/presentation/res/keys.dart';

import '../app_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Test clear all search history', (tester) async {
    final app = await appTest();
    await tester.pumpWidget(app);

    final textField = find.byKey(Key(Keys.searchTextField));
    final weatherInformation = find.byKey(Key(Keys.weatherInformation));
    final searchButton = find.byKey(Key(Keys.searchButton));
    final searchHistoryNavigateButton = find.byKey(
      Key(Keys.searchHistoryNavigateButton),
    );
    expect(weatherInformation, findsNothing);
    expect(textField, findsOneWidget);

    await tester.enterText(textField, 'Viet Nam');
    await tester.tap(searchButton);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(searchHistoryNavigateButton);
    await tester.pumpAndSettle();

    final widgets = tester.widgetList(find.byType(WeatherInformation));
    expect(widgets.length, 1);

    final clearRecords =
        find.byKey(Key(Keys.appBarClearAllSearchHistoryButton));
    await tester.tap(clearRecords);
    await tester.pumpAndSettle();

    final newWidgets = tester.widgetList(find.byType(WeatherInformation));
    expect(newWidgets.length, 0);
  });
}
