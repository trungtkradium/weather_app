import 'package:get/get.dart';
import 'package:sqlite3/common.dart';
import 'package:weather_app/src/constants/constants.dart';
import 'package:weather_app/src/repository/weather/weather_repository.dart';
import 'package:weather_app/src/repository/weather/weather_restful_service.dart';
import 'package:weather_app/src/repository/weather/weather_sqlite_service.dart';

void registerWeatherDependencies() {
  final localDb = Get.find<CommonDatabase>(tag: localDbName);
  final restful = Get.put<RestfulWeatherService>(
    RestfulWeatherService(),
    permanent: true,
  );
  final sqlite = Get.put<WeatherSqliteService>(
    WeatherSqliteService(localDb),
    permanent: true,
  );
  Get.put<WeatherRepository>(
    WeatherRepository(restful, sqlite),
    permanent: true,
  );
}
