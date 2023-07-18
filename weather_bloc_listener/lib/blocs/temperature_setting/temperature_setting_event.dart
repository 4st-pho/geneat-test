part of 'temperature_setting_bloc.dart';

abstract class TemperatureSettingEvent extends Equatable {
  const TemperatureSettingEvent();

  @override
  List<Object> get props => [];
}

class TemperatureSettingChanged extends TemperatureSettingEvent {
  const TemperatureSettingChanged();
}
