import 'package:test/test.dart';
import 'package:weather_app/src/utils/app_utils.dart';

void main() {
  group('Test AppUtils', () {
    test('Test fromCelsiusToFahrenheit', () {
      final f = AppUtils.fromCelsiusToFahrenheit(37.0);
      expect(f, '98.60');
    });

    test('Test getDegreeSymbol', () {
      final symbol1 = AppUtils.getDegreeSymbol(true);
      final symbol2 = AppUtils.getDegreeSymbol(false);

      expect(symbol1, '\u2103');
      expect(symbol2, '\u2109');
    });

    test('Test formatYMEd', () {
      final date = DateTime(2023, 10, 19);
      final dateString = AppUtils.formatYMEd(date);
      expect(dateString, 'Thu, 10/19/2023 12:00:00 AM');
    });
  });
}
