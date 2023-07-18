import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'temperature_setting_event.dart';
part 'temperature_setting_state.dart';

class TemperatureSettingBloc
    extends Bloc<TemperatureSettingEvent, TemperatureSettingState> {
  TemperatureSettingBloc() : super(TemperatureSettingState.initial()) {
    on<TemperatureSettingChanged>(_toggleTemperatureUnit);
  }

  FutureOr<void> _toggleTemperatureUnit(
    TemperatureSettingChanged event,
    Emitter<TemperatureSettingState> emit,
  ) {
    emit(state.copyWith(
      temperatureUnit: state.temperatureUnit == TemperatureUnit.celcius
          ? TemperatureUnit.fahrenheit
          : TemperatureUnit.celcius,
    ));
  }
}
