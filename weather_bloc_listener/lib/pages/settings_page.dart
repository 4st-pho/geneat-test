import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc/constants/app_strings.dart';
import 'package:weather_bloc/blocs/temperature_setting/temperature_setting_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppString.settings)),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          title: const Text(AppString.temperatureUnit),
          subtitle: const Text(AppString.celsiusOrFahrenheit),
          trailing:
              BlocBuilder<TemperatureSettingBloc, TemperatureSettingState>(
            builder: (context, state) {
              return _buildSwiftButton(state.temperatureUnit, context);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSwiftButton(
    TemperatureUnit temperatureUnit,
    BuildContext context,
  ) {
    return Switch(
      value: temperatureUnit == TemperatureUnit.celcius ? false : true,
      onChanged: (_) => context.read<TemperatureSettingBloc>().add(
            const TemperatureSettingChanged(),
          ),
    );
  }
}
