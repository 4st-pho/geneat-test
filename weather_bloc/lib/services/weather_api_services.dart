import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_bloc/constants/constants.dart';
import 'package:weather_bloc/models/weather.dart';
import 'package:weather_bloc/utils/http_error_hanlder.dart';

class WeatherApiServices {
  final http.Client httpClient;
  WeatherApiServices({required this.httpClient});

  Future<Weather> fetchWeatherByCoordinates(
      {required double latitude, required double longitude}) async {
    final uri = Uri(
        scheme: 'https',
        host: kHost,
        path: '/v1/forecast',
        queryParameters: {
          'latitude': latitude.toString(),
          'longitude': longitude.toString(),
          'current_weather': 'true',
        });
    try {
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception(httpErrorHanlder(response));
      }
      final weatherJson = json.decode(response.body);
      return Weather.fromJson(weatherJson);
    } catch (e) {
      rethrow;
    }
  }
}
