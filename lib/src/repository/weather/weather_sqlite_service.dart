import 'package:sqlite3/common.dart';
import 'package:weather_app/src/business/abstract_weather_repository.dart';
import 'package:weather_app/src/entity/country.dart';
import 'package:weather_app/src/entity/weather.dart';

class WeatherSqliteService implements AbstractWeatherRepository {
  final CommonDatabase _sqliteService;

  WeatherSqliteService(this._sqliteService) {
    _sqliteService.execute('''
        CREATE table IF NOT EXISTS search_history (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            country TEXT,
            weather_name TEXT,
            weather_description TEXT,
            weather_icon_url TEXT,
            celsius_temperature REAL,
            created_at INTEGER,
            is_deleted INTEGER
        );
    ''');
  }

  @override
  Weather insertSearchWeatherHistory(Weather weather) {
    final query = _sqliteService.prepare('''
          INSERT INTO search_history(country, weather_name, weather_description, weather_icon_url, celsius_temperature, created_at, is_deleted) 
          VALUES(?, ?, ?, ?, ?, ?, ?);
        ''');
    query.execute([
      weather.country,
      weather.name,
      weather.description,
      weather.iconUrl,
      weather.celsiusTemperature,
      weather.createdAt,
      0,
    ]);

    return weather;
  }

  @override
  Iterable<Weather> getSearchWeatherHistory(
    int page,
    int pageSize,
  ) {
    final ResultSet resultSet = _sqliteService.select(
      'SELECT * FROM search_history WHERE is_deleted = 0 LIMIT $pageSize OFFSET ${(page - 1) * pageSize};',
    );

    final result = <Weather>[];

    for (final Row row in resultSet) {
      final weather = Weather.fromRow(row);
      result.add(weather);
    }

    return result;
  }

  @override
  void clearSearchWeatherHistory() {
    final query = _sqliteService.prepare('''
          UPDATE search_history
          SET is_deleted = 1
          WHERE is_deleted = 0;
        ''');
    query.execute();
  }

  @override
  Future<Weather> getWeatherByCoordinate(
    String countryName,
    double lat,
    double lon,
  ) {
    // TODO: implement getWeatherByKeyword
    throw UnimplementedError();
  }

  @override
  Future<Country> getCountryByKeyword(String keyword) {
    // TODO: implement getCountryByKeyword
    throw UnimplementedError();
  }

  @override
  Future<Country> getCountryByZipcode(String zipcode) {
    // TODO: implement getCountryByKeyword
    throw UnimplementedError();
  }
}
