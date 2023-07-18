import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'temperature_setting_state.dart';

class TemperatureSettingCubit extends Cubit<TemperatureSettingState> {
  TemperatureSettingCubit() : super(TemperatureSettingState.initial());

  void toggleTemperatureUnit() {
    emit(state.copyWith(
      temperatureUnit: state.temperatureUnit == TemperatureUnit.celcius
          ? TemperatureUnit.fahrenheit
          : TemperatureUnit.celcius,
    ));
  }
}
