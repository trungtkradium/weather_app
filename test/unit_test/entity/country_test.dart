import 'dart:convert';

import 'package:test/test.dart';
import 'package:weather_app/src/entity/country.dart';

void main() {
  group('Test Country Model', () {
    test('Test Country Model fromJson success', () {
      final map = <String, dynamic>{
        'name': 'test',
        'lat': 50.0,
        'lon': 100.0,
      };
      final expectedModel = Country.fromJson(jsonDecode(jsonEncode(map)));

      expect(expectedModel.name, 'test');
      expect(expectedModel.lat, 50.0);
      expect(expectedModel.lon, 100.0);
    });
  });
}
