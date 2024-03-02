class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  Weather({
    required this.cityName,
    required this.mainCondition,
    required this.temperature,
  });
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['Name'],
        mainCondition: json['main']['temp'].toDouble(),
        temperature: json['Weather']);
  }
}
