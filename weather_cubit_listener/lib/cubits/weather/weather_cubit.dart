import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_cubit_listener/models/custom_error.dart';
import 'package:weather_cubit_listener/models/weather.dart';
import 'package:weather_cubit_listener/repositories/weather_repositories.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherCubit({required this.weatherRepository})
      : super(WeatherState.initial());

  Future<void> fetchWeather({
    required double latitude,
    required double longitude,
  }) async {
    emit(state.copyWith(status: WeatherStatus.loading));
    try {
      final weather = await weatherRepository.fetchWeatherByCoordinates(
          latitude: latitude, longitude: longitude);
      emit(state.copyWith(status: WeatherStatus.loaded, weather: weather));
    } catch (e) {
      emit(state.copyWith(
        status: WeatherStatus.error,
        error: CustomError(errorMessage: e.toString()),
      ));
    }
  }
}
