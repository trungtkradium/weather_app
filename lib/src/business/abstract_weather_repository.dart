import 'package:weather_app/src/entity/country.dart';
import 'package:weather_app/src/entity/weather.dart';

abstract class AbstractWeatherRepository {
  Future<Country> getCountryByKeyword(String keyword);

  Future<Country> getCountryByZipcode(String zipcode);

  Future<Weather> getWeatherByCoordinate(
    String countryName,
    double lat,
    double lon,
  );

  Weather insertSearchWeatherHistory(Weather weather);

  Iterable<Weather> getSearchWeatherHistory(int page, int pageSize);

  void clearSearchWeatherHistory();
}
