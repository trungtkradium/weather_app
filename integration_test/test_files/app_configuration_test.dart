import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:weather_app/src/presentation/app_configuration.dart';
import 'package:weather_app/src/presentation/res/keys.dart';

import '../app_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('App Configuration Default', (tester) async {
    final app = await appTest();
    final appConfiguration = AppConfiguration.to;
    await tester.pumpWidget(app);

    final menuButton = find.byKey(Key(Keys.appBarMenuButton));
    expect(menuButton, findsOneWidget);

    await tester.tap(menuButton);
    await tester.pumpAndSettle();

    final darkModeButton = find.byKey(
      Key(Keys.appBarMenuDarkModeOptionButton(Get.isDarkMode)),
    );
    final celsiusButton = find.byKey(
      Key(Keys.appBarMenuMetricOptionButton(
        appConfiguration.isUseCelsius.value,
      )),
    );

    expect(darkModeButton, findsOneWidget);
    expect(celsiusButton, findsOneWidget);

    await tester.tap(darkModeButton);
    await tester.pumpAndSettle();
    await tester.tap(menuButton);
    await tester.pumpAndSettle();

    final darkModeButtonSwitch = find.byKey(
      Key(Keys.appBarMenuDarkModeOptionButton(Get.isDarkMode)),
    );

    expect(darkModeButton, findsNothing);
    expect(darkModeButtonSwitch, findsOneWidget);

    await tester.tap(celsiusButton);
    await tester.pumpAndSettle();
    await tester.tap(menuButton);
    await tester.pumpAndSettle();

    final celsiusButtonSwitch = find.byKey(
      Key(Keys.appBarMenuMetricOptionButton(
        appConfiguration.isUseCelsius.value,
      )),
    );

    expect(celsiusButton, findsNothing);
    expect(celsiusButtonSwitch, findsOneWidget);
  });
}
