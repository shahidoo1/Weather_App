import 'dart:convert';

import 'package:weather_app/data/data_provider/weather_data_provider.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherRepository {
  final WeatherDataProvider weatherDataProvider;

  WeatherRepository(this.weatherDataProvider);
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    try {
      // String cityName = 'London';
      final WeatherData =
          await WeatherDataProvider().getCurrentWeather(cityName);

      final data = jsonDecode(WeatherData);

      if (data['cod'] != '200') {
        // If the API returns a non-200 status code (e.g., city not found)
        throw Exception(' ${data['message']}');
      }

      return WeatherModel.fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }
}
