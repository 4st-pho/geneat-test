import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc/models/custom_error.dart';
import 'package:weather_bloc/models/weather.dart';
import 'package:weather_bloc/repositories/weather_repositories.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository})
      : super(WeatherState.initial()) {
    on<WeatherFetched>(_fetchWeather);
  }

  Future<void> _fetchWeather(
    WeatherFetched event,
    Emitter<WeatherState> emit,
  ) async {
    emit(state.copyWith(status: WeatherStatus.loading));
    try {
      final weather = await weatherRepository.fetchWeatherByCoordinates(
          latitude: event.latitude, longitude: event.longitude);
      emit(state.copyWith(status: WeatherStatus.loaded, weather: weather));
    } catch (e) {
      emit(state.copyWith(
        status: WeatherStatus.error,
        error: CustomError(errorMessage: e.toString()),
      ));
    }
  }
}
