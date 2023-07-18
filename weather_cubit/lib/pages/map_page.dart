import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_cubit/constants/app_strings.dart';
import 'package:weather_cubit/cubits/weather/weather_cubit.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  static var coordinates = const LatLng(21.028511, 105.847130);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            onCameraMove: (position) => coordinates = position.target,
            mapType: MapType.normal,
            initialCameraPosition:
                CameraPosition(target: coordinates, zoom: 10),
          ),
          const Icon(Icons.location_on, color: Colors.red, size: 30),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.read<WeatherCubit>().fetchWeather(
              latitude: coordinates.latitude, longitude: coordinates.longitude);
          Navigator.of(context).pop();
        },
        label: const Text(AppString.select),
        icon: const Icon(Icons.done),
        backgroundColor: Colors.red,
      ),
    );
  }
}
