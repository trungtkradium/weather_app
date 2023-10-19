import 'package:weather_app/src/entity/country.dart';

Country getMockCountry() {
  return const Country('country', 50.0, 100.0);
}

Iterable<Country> getMockCountries(int length) {
  return List.generate(
    length,
    (index) => Country('country $index', 1.0 * index, 2.0 * index),
  );
}
