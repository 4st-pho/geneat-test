part of 'temperature_setting_cubit.dart';

enum TemperatureUnit { celcius, fahrenheit }

class TemperatureSettingState extends Equatable {
  final TemperatureUnit temperatureUnit;

  const TemperatureSettingState(this.temperatureUnit);
  factory TemperatureSettingState.initial() {
    return const TemperatureSettingState(TemperatureUnit.celcius);
  }

  @override
  List<Object> get props => [temperatureUnit];

  TemperatureSettingState copyWith({TemperatureUnit? temperatureUnit}) {
    return TemperatureSettingState(temperatureUnit ?? this.temperatureUnit);
  }
}
