import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_app/pages.dart';
import 'package:weather_app/src/di/di.dart';
import 'package:weather_app/src/presentation/screens/weather_screen.dart';

Future<Widget> appTest() async {
  initializeDateFormatting();
  await registerDependencies();
  return GetMaterialApp(
    title: 'Weather App',
    debugShowCheckedModeBanner: false,
    initialRoute: WeatherScreen.routeName,
    getPages: pages,
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    themeMode: ThemeMode.light,
  );
}
