import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc/blocs/weather/weather_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final WeatherBloc weatherBloc;
  late final StreamSubscription weatherBlocListener;
  ThemeBloc({required this.weatherBloc}) : super(ThemeState.initial()) {
    on<ThemeChanged>((event, emit) {
      emit(state.copyWith(appTheme: event.appTheme));
    });

    weatherBlocListener = weatherBloc.stream.listen((event) {
      if (((event.weather.currentWeather?.temperature) ?? 30) > 20) {
        add(const ThemeChanged(appTheme: AppTheme.light));
      } else {
        add(const ThemeChanged(appTheme: AppTheme.dark));
      }
    });
  }

  @override
  Future<void> close() {
    weatherBlocListener.cancel();
    return super.close();
  }
}
