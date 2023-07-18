import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_cubit/cubits/weather/weather_cubit.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final WeatherCubit weatherCubit;
  late final StreamSubscription weatherCubitListener;

  ThemeCubit({required this.weatherCubit}) : super(ThemeState.initial()) {
    weatherCubitListener = weatherCubit.stream.listen((event) {
      if (((event.weather.currentWeather?.temperature) ?? 30) > 20) {
        emit(state.copyWith(appTheme: AppTheme.light));
      } else {
        emit(state.copyWith(appTheme: AppTheme.dark));
      }
    });
  }

  @override
  Future<void> close() {
    weatherCubitListener.cancel();
    return super.close();
  }
}
