import 'package:get/get.dart';
import 'package:weather_app/src/presentation/screens/weather_history_screen.dart';
import 'package:weather_app/src/presentation/screens/weather_screen.dart';

final pages = <GetPage<dynamic>>[
  GetPage(
    name: WeatherScreen.routeName,
    page: () => const WeatherScreen(),
    bindings: [WeatherScreenBinding()],
  ),
  GetPage(
    name: WeatherHistoryScreen.routeName,
    page: () => const WeatherHistoryScreen(),
    bindings: [WeatherHistoryScreenBinding()],
  ),
];
