import 'package:get/get.dart';
import 'package:weather_app/src/business/abstract_weather_repository.dart';
import 'package:weather_app/src/entity/country.dart';
import 'package:weather_app/src/entity/weather.dart';

class WeatherState {
  WeatherState(this._repository);

  static WeatherState get to => Get.find<WeatherState>();

  final AbstractWeatherRepository _repository;

  final currentWeather = Rx<Weather?>(null);
  final searchHistory = <Weather>[].obs;
  final countries = <Country>[];

  Future<Weather> searchWeather(String searchKeyword) async {
    late Country country;
    final isZipCode = int.tryParse(searchKeyword) != null;
    if (isZipCode) {
      country = await _repository.getCountryByZipcode(searchKeyword);
    } else {
      country = await _repository.getCountryByKeyword(searchKeyword);
    }
    final weather = await _repository.getWeatherByCoordinate(
      country.name,
      country.lat,
      country.lon,
    );
    currentWeather.value = weather;
    _repository.insertSearchWeatherHistory(weather);
    return weather;
  }

  Iterable<Weather> getSearchWeatherHistory(
    int page, {
    int pageSize = 10,
  }) {
    final weathers = _repository.getSearchWeatherHistory(page, pageSize);
    if (page == 1) {
      searchHistory.clear();
    }
    searchHistory.addAll(weathers);
    return weathers;
  }

  void clearSearchWeatherHistory() {
    _repository.clearSearchWeatherHistory();
    searchHistory.clear();
  }
}
