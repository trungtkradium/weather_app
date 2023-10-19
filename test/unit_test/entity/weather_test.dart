import 'dart:convert';

import 'package:test/test.dart';
import 'package:weather_app/src/entity/Weather.dart';

void main() {
  group('Test Weather Model', () {
    test('Test Weather Model fromJson success', () {
      final map = <String, dynamic>{
        'main': {'temp': 30.0},
        'dt': 1,
        'weather': [
          {
            'main': 'main',
            'description': 'description',
            'icon': 'icon',
          }
        ],
      };
      final expectedModel = Weather.fromJson(
        'country',
        jsonDecode(jsonEncode(map)),
      );

      expect(expectedModel.country, 'country');
      expect(expectedModel.name, 'main');
      expect(expectedModel.description, 'description');
      expect(expectedModel.iconUrl,
          'https://openweathermap.org/img/wn/icon@2x.png');
      expect(expectedModel.celsiusTemperature, 30.0);
      expect(expectedModel.createdAt, 1000);
    });
  });
}
