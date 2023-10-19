import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/src/business/weather_state.dart';
import 'package:weather_app/src/entity/weather.dart';
import 'package:weather_app/src/repository/weather/weather_repository.dart';
import 'package:weather_app/src/repository/weather/weather_restful_service.dart';
import 'package:weather_app/src/repository/weather/weather_sqlite_service.dart';
import '../mock/mock_country.dart';
import '../mock/mock_weather.dart';
import 'weather_state_test.mocks.dart';

@GenerateMocks([
  RestfulWeatherService,
  WeatherSqliteService,
])
void main() {
  group('Test Weather State', () {
    test('Test init', () {
      final weatherState = WeatherState(WeatherRepository(
        MockRestfulWeatherService(),
        MockWeatherSqliteService(),
      ));

      expect(weatherState.currentWeather.value, null);
      expect(weatherState.searchHistory, []);
      expect(weatherState.countries, []);
    });

    group('Test searchWeather', () {
      test('Test searchWeather by keyword success', () {
        final restfulService = MockRestfulWeatherService();
        final sqliteService = MockWeatherSqliteService();
        final weatherState = WeatherState(
          WeatherRepository(restfulService, sqliteService),
        );
        const keyword = 'Viet Nam';
        final country = getMockCountry();
        final weather = getMockWeather();

        when(restfulService.getCountryByKeyword(keyword))
            .thenAnswer((_) async => country);
        when(restfulService.getWeatherByCoordinate(
          country.name,
          country.lat,
          country.lon,
        )).thenAnswer((_) async => weather);
        when(sqliteService.insertSearchWeatherHistory(weather))
            .thenReturn(weather);

        weatherState.searchWeather(keyword).then((value) {
          verify(restfulService.getCountryByKeyword(keyword)).called(1);
          verify(restfulService.getWeatherByCoordinate(
            country.name,
            country.lat,
            country.lon,
          )).called(1);
          verify(sqliteService.insertSearchWeatherHistory(weather)).called(1);
          expect(weatherState.currentWeather.value, weather);
          expect(value, weather);
        });
      });

      test('Test searchWeather by zipcode success', () {
        final restfulService = MockRestfulWeatherService();
        final sqliteService = MockWeatherSqliteService();
        final weatherState = WeatherState(
          WeatherRepository(restfulService, sqliteService),
        );
        const zipcode = '700000';
        final country = getMockCountry();
        final weather = getMockWeather();

        when(restfulService.getCountryByZipcode(zipcode))
            .thenAnswer((_) async => country);
        when(restfulService.getWeatherByCoordinate(
          country.name,
          country.lat,
          country.lon,
        )).thenAnswer((_) async => weather);
        when(sqliteService.insertSearchWeatherHistory(weather))
            .thenReturn(weather);

        weatherState.searchWeather(zipcode).then((value) {
          verify(restfulService.getCountryByZipcode(zipcode)).called(1);
          verify(restfulService.getWeatherByCoordinate(
            country.name,
            country.lat,
            country.lon,
          )).called(1);
          verify(sqliteService.insertSearchWeatherHistory(weather)).called(1);
          expect(weatherState.currentWeather.value, weather);
          expect(value, weather);
        });
      });

      test('Test searchWeather getWeatherByCoordinate Failed', () {
        final restfulService = MockRestfulWeatherService();
        final sqliteService = MockWeatherSqliteService();
        final weatherState = WeatherState(
          WeatherRepository(restfulService, sqliteService),
        );
        const zipcode = '700000';
        final country = getMockCountry();
        final weather = getMockWeather();
        final exception = Exception('search weather failed');

        when(restfulService.getCountryByZipcode(zipcode))
            .thenAnswer((_) async => country);
        when(restfulService.getWeatherByCoordinate(
          country.name,
          country.lat,
          country.lon,
        )).thenThrow(exception);

        weatherState.searchWeather(zipcode).then<Weather>((value) {
          throw 'Unreachable';
        }).catchError(
          (error) {
            verify(restfulService.getCountryByZipcode(zipcode)).called(1);
            verify(restfulService.getWeatherByCoordinate(
              country.name,
              country.lat,
              country.lon,
            )).called(1);
            verifyNever(sqliteService.insertSearchWeatherHistory(weather));
            expect(weatherState.currentWeather.value, null);
            return weather;
          },
          test: (e) => e == exception,
        );
      });

      test('Test searchWeather getCountryByKeyword Failed', () {
        final restfulService = MockRestfulWeatherService();
        final sqliteService = MockWeatherSqliteService();
        final weatherState = WeatherState(
          WeatherRepository(restfulService, sqliteService),
        );
        const keyword = 'Viet Nam';
        final country = getMockCountry();
        final weather = getMockWeather();
        final exception = Exception('get country by keyword failed');

        when(restfulService.getCountryByKeyword(keyword)).thenThrow(exception);

        weatherState.searchWeather(keyword).then<Weather>((value) {
          throw 'Unreachable';
        }).catchError(
          (error) {
            verify(restfulService.getCountryByKeyword(keyword)).called(1);
            verifyNever(restfulService.getWeatherByCoordinate(
              country.name,
              country.lat,
              country.lon,
            ));
            verifyNever(sqliteService.insertSearchWeatherHistory(weather));
            expect(weatherState.currentWeather.value, null);
            return weather;
          },
          test: (e) => e == exception,
        );
      });
    });

    group('Test getSearchWeatherHistory', () {
      test('Test getSearchWeatherHistory first page success', () {
        final restfulService = MockRestfulWeatherService();
        final sqliteService = MockWeatherSqliteService();
        final weatherState = WeatherState(
          WeatherRepository(restfulService, sqliteService),
        );
        final mockWeathers = getMockWeathers(10);
        weatherState.searchHistory.addAll(getMockWeathers(5));
        expect(weatherState.searchHistory.length, 5);

        when(sqliteService.getSearchWeatherHistory(1, 10))
            .thenReturn(mockWeathers);
        final weathers = weatherState.getSearchWeatherHistory(1);
        expect(weatherState.searchHistory, mockWeathers);
        expect(weathers, mockWeathers);
      });

      test('Test getSearchWeatherHistory continuous page success', () {
        final restfulService = MockRestfulWeatherService();
        final sqliteService = MockWeatherSqliteService();
        final weatherState = WeatherState(
          WeatherRepository(restfulService, sqliteService),
        );
        final mockWeathers = getMockWeathers(10);
        weatherState.searchHistory.addAll(getMockWeathers(5));
        expect(weatherState.searchHistory.length, 5);

        when(sqliteService.getSearchWeatherHistory(2, 10))
            .thenReturn(mockWeathers);
        final weathers = weatherState.getSearchWeatherHistory(2);
        expect(weatherState.searchHistory.length, 15);
        expect(weathers, mockWeathers);
      });

      test('Test getSearchWeatherHistory failed', () {
        final restfulService = MockRestfulWeatherService();
        final sqliteService = MockWeatherSqliteService();
        final weatherState = WeatherState(
          WeatherRepository(restfulService, sqliteService),
        );
        final exception = Exception('get search weather history failed');
        weatherState.searchHistory.addAll(getMockWeathers(5));
        expect(weatherState.searchHistory.length, 5);

        when(sqliteService.getSearchWeatherHistory(2, 10)).thenThrow(exception);

        Iterable<Weather>? weathers;

        try {
          weathers = weatherState.getSearchWeatherHistory(2);
        } catch (e) {
          expect(e, exception);
        }

        expect(weatherState.searchHistory.length, 5);
        expect(weathers, null);
      });
    });

    group('Test clearSearchWeatherHistory', () {
      test('Test clearSearchWeatherHistory success', () {
        final restfulService = MockRestfulWeatherService();
        final sqliteService = MockWeatherSqliteService();
        final weatherState = WeatherState(
          WeatherRepository(restfulService, sqliteService),
        );
        weatherState.searchHistory.addAll(getMockWeathers(5));
        expect(weatherState.searchHistory.length, 5);

        when(sqliteService.clearSearchWeatherHistory()).thenReturn(null);

        weatherState.clearSearchWeatherHistory();

        expect(weatherState.searchHistory, []);
      });

      test('Test clearSearchWeatherHistory failed', () {
        final restfulService = MockRestfulWeatherService();
        final sqliteService = MockWeatherSqliteService();
        final weatherState = WeatherState(
          WeatherRepository(restfulService, sqliteService),
        );
        final exception = Exception('clear search weather history failed');
        weatherState.searchHistory.addAll(getMockWeathers(5));
        expect(weatherState.searchHistory.length, 5);

        when(sqliteService.clearSearchWeatherHistory()).thenThrow(exception);

        try {
          weatherState.clearSearchWeatherHistory();
        } catch (e) {
          expect(e, exception);
        }

        expect(weatherState.searchHistory.length, 5);
      });
    });
  });
}
