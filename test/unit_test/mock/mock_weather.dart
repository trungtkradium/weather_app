import 'package:weather_app/src/entity/weather.dart';

Weather getMockWeather() {
  return Weather(
    country: 'country',
    name: 'name',
    description: 'description',
    iconUrl: 'iconUrl',
    celsiusTemperature: 30.0,
    createdAt: 1,
  );
}

Iterable<Weather> getMockWeathers(int length) {
  return List.generate(
    length,
    (index) => Weather(
      country: 'country $index',
      name: 'name $index',
      description: 'description $index',
      iconUrl: 'iconUrl $index',
      celsiusTemperature: 1.0 * index,
      createdAt: 1000 * index,
    ),
  );
}
