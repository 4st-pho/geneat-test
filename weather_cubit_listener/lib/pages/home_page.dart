import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_cubit_listener/constants/app_strings.dart';
import 'package:weather_cubit_listener/constants/app_text_style.dart';
import 'package:weather_cubit_listener/cubits/temperature_setting/temperature_setting_cubit.dart';
import 'package:weather_cubit_listener/cubits/theme/theme_cubit.dart';
import 'package:weather_cubit_listener/cubits/weather/weather_cubit.dart';
import 'package:weather_cubit_listener/models/weather.dart';
import 'package:weather_cubit_listener/pages/map_page.dart';
import 'package:weather_cubit_listener/pages/settings_page.dart';
import 'package:weather_cubit_listener/utils/utils.dart';

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
        .read<WeatherCubit>()
        .fetchWeather(latitude: 21.028511, longitude: 105.804817);
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
      body: BlocConsumer<WeatherCubit, WeatherState>(
        listener: (context, state) {
          context
              .read<ThemeCubit>()
              .updateTheme(state.weather.currentWeather?.temperature);
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
    return BlocBuilder<TemperatureSettingCubit, TemperatureSettingState>(
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
