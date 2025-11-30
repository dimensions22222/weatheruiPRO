import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String accessKey = '3b1883c4c8d377ec6c41f03dcfda9fdd';

  Future<Map<String, dynamic>> fetchWeather(String query) async {
    final uri = Uri.parse(
      'http://api.weatherstack.com/current?access_key=$accessKey&query=${Uri.encodeComponent(query)}&units=m',
    );

    final res = await http.get(uri).timeout(const Duration(seconds: 10));

    if (res.statusCode != 200) {
      throw Exception('Network error: ${res.statusCode}');
    }

    final jsonBody = json.decode(res.body) as Map<String, dynamic>;

    if (jsonBody.containsKey('error')) {
      throw Exception(jsonBody['error']['info']);
    }

    return jsonBody;
  }
}
