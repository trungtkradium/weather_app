import 'package:weather_app/src/di/register_app_configurations.dart';
import 'package:weather_app/src/di/sqlite/register_sqlite.dart';
import 'package:weather_app/src/di/register_weather_dependencies.dart';

Future<void> registerDependencies() async {
  await registerSqlite();
  await registerAppConfigurations();
  registerWeatherDependencies();
}
