import 'package:weather_bloc/models/weather.dart';
import 'package:weather_bloc/services/weather_api_services.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;
  WeatherRepository({required this.weatherApiServices});

  Future<Weather> fetchWeatherByCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    return weatherApiServices.fetchWeatherByCoordinates(
      latitude: latitude,
      longitude: longitude,
    );
  }
}
