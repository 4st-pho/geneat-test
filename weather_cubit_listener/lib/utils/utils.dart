import 'package:weather_cubit_listener/constants/asset_images.dart';

class Utils {
  static String getWeatherStatusImage(double? temperature) {
    temperature ??= 0;
    if (temperature >= 40) {
      return AssetImages.superHot;
    } else if (temperature >= 30) {
      return AssetImages.hot;
    } else if (temperature >= 20) {
      return AssetImages.normal;
    } else if (temperature >= 10) {
      return AssetImages.cold;
    }
    return AssetImages.superCold;
  }
}
