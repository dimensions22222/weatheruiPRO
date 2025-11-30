import '../services/weather_service.dart';
import '../models/weather_model.dart';

class WeatherPresenter {
  final WeatherService service = WeatherService();

  Future<WeatherModel> loadWeather(String query) async {
    final data = await service.fetchWeather(query);
    return WeatherModel.fromJson(data);
  }
}
