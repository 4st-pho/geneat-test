import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final double? latitude;
  final double? longitude;
  final double? generationtimeMs;
  final int? utcOffsetSeconds;
  final String? timezone;
  final String? timezoneAbbreviation;
  final double? elevation;
  final CurrentWeather? currentWeather;

  const Weather({
    this.latitude,
    this.longitude,
    this.generationtimeMs,
    this.utcOffsetSeconds,
    this.timezone,
    this.timezoneAbbreviation,
    this.elevation,
    this.currentWeather,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      latitude: json['latitude'],
      longitude: json['longitude'],
      generationtimeMs: json['generationtime_ms'],
      utcOffsetSeconds: json['utc_offset_seconds'],
      timezone: json['timezone'],
      timezoneAbbreviation: json['timezone_abbreviation'],
      elevation: json['elevation'],
      currentWeather: json['current_weather'] != null
          ? CurrentWeather.fromJson(json['current_weather'])
          : null,
    );
  }

  @override
  List<Object?> get props {
    return [
      latitude,
      longitude,
      generationtimeMs,
      utcOffsetSeconds,
      timezone,
      timezoneAbbreviation,
      elevation,
      currentWeather,
    ];
  }

  @override
  bool? get stringify => true;
}

class CurrentWeather extends Equatable {
  final double? temperature;
  final double? windspeed;
  final double? winddirection;
  final int? weathercode;
  final int? isDay;
  final String? time;
  const CurrentWeather({
    this.temperature,
    this.windspeed,
    this.winddirection,
    this.weathercode,
    this.isDay,
    this.time,
  });

  @override
  List<Object?> get props {
    return [temperature, windspeed, winddirection, weathercode, isDay, time];
  }

  @override
  bool? get stringify => true;

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      temperature: json['temperature'],
      windspeed: json['windspeed'],
      winddirection: json['winddirection'],
      weathercode: json['weathercode'],
      isDay: json['is_day'],
      time: json['time'],
    );
  }
}
