class AirQuality {
  int aqi;
  List coord;
  DateTime dt;
  Map components;
  String? message;
  String? emoji;

  AirQuality({
    required this.aqi,
    required this.coord,
    required this.dt,
    required this.components,
  });

  factory AirQuality.fromJson(Map<String, dynamic> json) {
    return AirQuality(
      aqi: json['list']['main']['aqi'],
      coord: json['coord'],
      dt: json['list']['dt'],
      components: json['list']['components'],
    );
  }

  @override
  String toString() {
    return 'AirQuality(aqi: $aqi, coord: $coord, dt: $dt, components: $components, message: $message, emoji: $emoji)';
  }
}
