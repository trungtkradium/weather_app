import 'package:weather_app/src/business/abstract_weather_repository.dart';
import 'package:weather_app/src/entity/country.dart';
import 'package:weather_app/src/entity/weather.dart';

class WeatherRepository extends AbstractWeatherRepository {
  final AbstractWeatherRepository remoteService;
  final AbstractWeatherRepository localService;

  WeatherRepository(this.remoteService, this.localService);

  @override
  Future<Weather> getWeatherByCoordinate(
    String countryName,
    double lat,
    double lon,
  ) {
    return remoteService.getWeatherByCoordinate(countryName, lat, lon);
  }

  @override
  Iterable<Weather> getSearchWeatherHistory(
    int page,
    int pageSize,
  ) {
    return localService.getSearchWeatherHistory(page, pageSize);
  }

  @override
  Future<Country> getCountryByKeyword(String keyword) {
    return remoteService.getCountryByKeyword(keyword);
  }

  @override
  Future<Country> getCountryByZipcode(String zipcode) {
    return remoteService.getCountryByZipcode(zipcode);
  }

  @override
  Weather insertSearchWeatherHistory(Weather weather) {
    return localService.insertSearchWeatherHistory(weather);
  }

  @override
  void clearSearchWeatherHistory() {
    return localService.clearSearchWeatherHistory();
  }
}
