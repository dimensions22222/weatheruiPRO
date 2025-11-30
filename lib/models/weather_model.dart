class WeatherModel {
  final Map<String, dynamic> location;
  final Map<String, dynamic> current;

  WeatherModel({required this.location, required this.current});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: json['location'] as Map<String, dynamic>,
      current: json['current'] as Map<String, dynamic>,
    );
  }
}
