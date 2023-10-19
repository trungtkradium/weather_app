class Country {
  final String name;
  final double lat;
  final double lon;

  const Country(this.name, this.lat, this.lon);

  factory Country.fromJson(dynamic json) {
    return Country(json['name'], json['lat'], json['lon']);
  }
}
