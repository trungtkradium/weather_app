import 'package:get/get.dart';
import 'package:weather_app/src/business/abstract_weather_repository.dart';
import 'package:weather_app/src/entity/country.dart';
import 'package:weather_app/src/entity/weather.dart';

class RestfulWeatherService extends GetConnect
    implements AbstractWeatherRepository {
  final String _domain = 'https://api.openweathermap.org';
  final _baseQuery = '&appid=77b5ac988b4ca69cc800054b4168d458';

  String getCountryByKeywordApi(String keyword) =>
      '/geo/1.0/direct?q=$keyword&limit=1$_baseQuery';
  String getCountryByZipcodeApi(String zipcode) =>
      '/geo/1.0/zip?zip=$zipcode$_baseQuery';
  String getCurrentWeatherApi(double lat, double lon) =>
      '/data/2.5/weather?lat=$lat&lon=$lon&units=metric$_baseQuery';

  @override
  void onInit() {
    super.onInit();
    baseUrl = _domain;
  }

  @override
  Future<Weather> getWeatherByCoordinate(
    String countryName,
    double lat,
    double lon,
  ) async {
    final response = await get(getCurrentWeatherApi(lat, lon));

    if (response.statusCode != 200) {
      throw Exception(response.statusText ?? response.statusCode);
    }

    final weather = Weather.fromJson(countryName, response.body);
    return weather;
  }

  @override
  Future<Country> getCountryByKeyword(String keyword) async {
    final response = await get(getCountryByKeywordApi(keyword));

    if (response.statusCode != 200) {
      throw Exception(response.statusText ?? response.statusCode);
    }

    for (final item in response.body ?? []) {
      final country = Country.fromJson(item);
      return country;
    }

    throw Exception('Can not find any location base on keyword');
  }

  @override
  Future<Country> getCountryByZipcode(String zipcode) async {
    final response = await get(getCountryByZipcodeApi(zipcode));

    if (response.statusCode != 200) {
      throw Exception(response.statusText ?? response.statusCode);
    }

    final country = Country.fromJson(response.body);
    return country;
  }

  @override
  Weather insertSearchWeatherHistory(Weather weather) {
    // TODO: implement insertSearchWeatherHistory
    throw UnimplementedError();
  }

  @override
  Iterable<Weather> getSearchWeatherHistory(int page, int pageSize) {
    throw UnimplementedError();
  }

  @override
  void clearSearchWeatherHistory() {
    // TODO: implement clearSearchWeatherHistory
    throw UnimplementedError();
  }
}
