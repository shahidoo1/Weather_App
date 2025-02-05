// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class WeatherModel {
  final double currentTemp;
  final String currentSky;
  final double currentPressure;
  final double currentWindSpeed;
  final double currentHumidity;
  final List<HourlyForecast> hourlyForecast;

  WeatherModel({
    required this.currentTemp,
    required this.currentSky,
    required this.currentPressure,
    required this.currentWindSpeed,
    required this.currentHumidity,
    required this.hourlyForecast,
  });

  WeatherModel copyWith({
    double? currentTemp,
    String? currentSky,
    double? currentPressure,
    double? currentWindSpeed,
    double? currentHumidity,
    List<HourlyForecast>? hourlyForecast,
  }) {
    return WeatherModel(
      currentTemp: currentTemp ?? this.currentTemp,
      currentSky: currentSky ?? this.currentSky,
      currentPressure: currentPressure ?? this.currentPressure,
      currentWindSpeed: currentWindSpeed ?? this.currentWindSpeed,
      currentHumidity: currentHumidity ?? this.currentHumidity,
      hourlyForecast: hourlyForecast ?? this.hourlyForecast,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentTemp': currentTemp,
      'currentSky': currentSky,
      'currentPressure': currentPressure,
      'currentWindSpeed': currentWindSpeed,
      'currentHumidity': currentHumidity,
      'hourlyForecast': hourlyForecast.map((x) => x.toMap()).toList(),
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    final currentWeatherData =
        map['list'][0]; // Get the first item from the list (current weather)
    print(
        "Weather Data: ${json.encode(map)}"); // Print the full response for debugging

    return WeatherModel(
      currentTemp: (currentWeatherData['main']['temp'] as num).toDouble(),
      currentSky: currentWeatherData['weather'][0]['main'],
      currentPressure:
          (currentWeatherData['main']['pressure'] as num).toDouble(),
      currentWindSpeed: (currentWeatherData['wind']['speed'] as num).toDouble(),
      currentHumidity:
          (currentWeatherData['main']['humidity'] as num).toDouble(),
      hourlyForecast: List<HourlyForecast>.from(
        (map['list'] as List<dynamic>).map<HourlyForecast>(
          (x) => HourlyForecast.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeatherModel(currentTemp: $currentTemp, currentSky: $currentSky, currentPressure: $currentPressure, currentWindSpeed: $currentWindSpeed, currentHumidity: $currentHumidity, hourlyForecast: $hourlyForecast)';
  }

  @override
  bool operator ==(covariant WeatherModel other) {
    if (identical(this, other)) return true;

    return other.currentTemp == currentTemp &&
        other.currentSky == currentSky &&
        other.currentPressure == currentPressure &&
        other.currentWindSpeed == currentWindSpeed &&
        other.currentHumidity == currentHumidity &&
        listEquals(other.hourlyForecast, hourlyForecast);
  }

  @override
  int get hashCode {
    return currentTemp.hashCode ^
        currentSky.hashCode ^
        currentPressure.hashCode ^
        currentWindSpeed.hashCode ^
        currentHumidity.hashCode ^
        hourlyForecast.hashCode;
  }
}

class HourlyForecast {
  final String time;
  final double temperature;
  final String skyCondition;

  HourlyForecast({
    required this.time,
    required this.temperature,
    required this.skyCondition,
  });

  HourlyForecast copyWith({
    String? time,
    double? temperature,
    String? skyCondition,
  }) {
    return HourlyForecast(
      time: time ?? this.time,
      temperature: temperature ?? this.temperature,
      skyCondition: skyCondition ?? this.skyCondition,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time,
      'temperature': temperature,
      'skyCondition': skyCondition,
    };
  }

  factory HourlyForecast.fromMap(Map<String, dynamic> map) {
    return HourlyForecast(
      time: map['dt_txt'] as String, // Use 'dt_txt' for the time
      temperature: (map['main']['temp'] as num)
          .toDouble(), // Get the temperature from 'main'
      skyCondition: map['weather'][0]['main']
          as String, // Get the sky condition from 'weather'
    );
  }

  String toJson() => json.encode(toMap());

  factory HourlyForecast.fromJson(String source) =>
      HourlyForecast.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'HourlyForecast(time: $time, temperature: $temperature, skyCondition: $skyCondition)';
}
