import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_app/pages.dart';
import 'package:weather_app/src/di/di.dart';
import 'package:weather_app/src/presentation/app_configuration.dart';

import 'src/presentation/screens/weather_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();
  await registerDependencies();
  final configuration = AppConfiguration.to;
  Get.changeTheme(
    configuration.getIsUseDarkMode ? ThemeData.dark() : ThemeData.light(),
  );

  runApp(
    GetMaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      initialRoute: WeatherScreen.routeName,
      getPages: pages,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
    ),
  );
}
