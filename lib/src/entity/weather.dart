import 'package:sqlite3/sqlite3.dart';

class Weather {
  final String country;
  final String name;
  final String description;
  final String iconUrl;
  final int createdAt;
  final double celsiusTemperature;

  Weather({
    required this.country,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.celsiusTemperature,
    required this.createdAt,
  });

  factory Weather.fromJson(String countryName, dynamic json) {
    final weatherInformation = json['weather'].first;
    return Weather(
      country: countryName,
      name: weatherInformation['main'],
      description: weatherInformation['description'],
      iconUrl:
          'https://openweathermap.org/img/wn/${weatherInformation['icon']}@2x.png',
      celsiusTemperature: json['main']['temp'],
      createdAt: json['dt'] * 1000,
    );
  }

  factory Weather.fromRow(Row row) {
    return Weather(
      country: row['country'],
      name: row['weather_name'],
      description: row['weather_description'],
      iconUrl: row['weather_icon_url'],
      celsiusTemperature: row['celsius_temperature'],
      createdAt: row['created_at'],
    );
  }
}
