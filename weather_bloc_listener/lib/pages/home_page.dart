import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc/blocs/theme/theme_bloc.dart';
import 'package:weather_bloc/constants/app_strings.dart';
import 'package:weather_bloc/constants/app_text_style.dart';
import 'package:weather_bloc/blocs/temperature_setting/temperature_setting_bloc.dart';
import 'package:weather_bloc/blocs/weather/weather_bloc.dart';
import 'package:weather_bloc/models/weather.dart';
import 'package:weather_bloc/pages/map_page.dart';
import 'package:weather_bloc/pages/settings_page.dart';
import 'package:weather_bloc/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context
        .read<WeatherBloc>()
        .add(const WeatherFetched(latitude: 21.028511, longitude: 105.847130));
  }

  void showPlacePicker() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MapPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocConsumer<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (((state.weather.currentWeather?.temperature) ?? 30) > 20) {
            context
                .read<ThemeBloc>()
                .add(const ThemeChanged(appTheme: AppTheme.light));
          } else {
            context
                .read<ThemeBloc>()
                .add(const ThemeChanged(appTheme: AppTheme.dark));
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case WeatherStatus.initial:
              return ElevatedButton(
                onPressed: showPlacePicker,
                child: const Text(AppString.selectLocation),
              );
            case WeatherStatus.error:
              return Center(
                  child: Text(
                state.error.errorMessage,
                style: AppTextStyle.red25px,
              ));
            case WeatherStatus.loaded:
              return _buildWeatherInfo(state.weather.currentWeather);
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(AppString.weather),
      actions: [
        IconButton(onPressed: showPlacePicker, icon: const Icon(Icons.map)),
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingsPage()));
          },
          icon: const Icon(Icons.settings),
        )
      ],
    );
  }

  Widget _buildWeatherInfo(CurrentWeather? currentWeather) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Center(
              child: Image.asset(
                Utils.getWeatherStatusImage(currentWeather?.temperature),
                width: 150,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTemperature(currentWeather),
                Text(
                  'Wind speed: ${currentWeather?.windspeed}',
                  style: AppTextStyle.blue20px,
                ),
                Text(
                  'Wind direction: ${currentWeather?.winddirection}',
                  style: AppTextStyle.green20px,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTemperature(CurrentWeather? currentWeather) {
    return BlocBuilder<TemperatureSettingBloc, TemperatureSettingState>(
      builder: (context, state) {
        return Text(
          state.temperatureUnit == TemperatureUnit.celcius
              ? 'Temperature: ${currentWeather?.temperature}°C'
              : 'Temperature: ${((currentWeather?.temperature ?? 0) * 9 / 5 + 32).toStringAsFixed(2)}°F',
          style: AppTextStyle.red25px,
        );
      },
    );
  }
}
