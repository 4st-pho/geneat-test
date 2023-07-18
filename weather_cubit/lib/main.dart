import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:weather_cubit/cubits/temperature_setting/temperature_setting_cubit.dart';
import 'package:weather_cubit/cubits/theme/theme_cubit.dart';
import 'package:weather_cubit/cubits/weather/weather_cubit.dart';
import 'package:weather_cubit/pages/home_page.dart';
import 'package:weather_cubit/repositories/weather_repositories.dart';
import 'package:weather_cubit/services/weather_api_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => WeatherRepository(
            weatherApiServices: WeatherApiServices(httpClient: http.Client()),
          ),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => WeatherCubit(
              weatherRepository: context.read<WeatherRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => TemperatureSettingCubit(),
          ),
          BlocProvider(
            create: (context) => ThemeCubit(
              weatherCubit: context.read<WeatherCubit>(),
            ),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state.appTheme == AppTheme.light
                  ? ThemeData(primarySwatch: Colors.blue, useMaterial3: true)
                  : ThemeData.dark(useMaterial3: true),
              home: const HomePage(),
            );
          },
        ),
      ),
    );
  }
}
