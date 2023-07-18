import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:weather_bloc/blocs/temperature_setting/temperature_setting_bloc.dart';
import 'package:weather_bloc/blocs/theme/theme_bloc.dart';
import 'package:weather_bloc/blocs/weather/weather_bloc.dart';
import 'package:weather_bloc/pages/home_page.dart';
import 'package:weather_bloc/repositories/weather_repositories.dart';
import 'package:weather_bloc/services/weather_api_services.dart';

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
            create: (context) => WeatherBloc(
              weatherRepository: context.read<WeatherRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => TemperatureSettingBloc(),
          ),
          BlocProvider(
            create: (context) => ThemeBloc(),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
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
