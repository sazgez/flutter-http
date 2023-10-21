class AirQuality {
  int aqi;
  int dt;
  Map components;
  String? message;
  String? emoji;

  AirQuality({
    required this.aqi,
    required this.dt,
    required this.components,
  });

  factory AirQuality.fromJson(Map<String, dynamic> json) {
    return AirQuality(
      aqi: json['list'][0]['main']['aqi'],
      dt: json['list'][0]['dt'],
      components: json['list'][0]['components'],
    );
  }

  @override
  String toString() {
    return 'AirQuality(aqi: $aqi, dt: $dt, components: $components, message: $message, emoji: $emoji)';
  }
}
