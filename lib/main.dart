import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/theme_bloc/theme_bloc.dart'; // Import your theme bloc
import 'package:weather_app/bloc/wether_bloc/weather_bloc.dart'; // Import your weather bloc
import 'package:weather_app/data/data_provider/weather_data_provider.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/presentation/screens/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(
          WeatherDataProvider()), // Providing the weather repository
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherBloc>(
            create: (context) => WeatherBloc(context.read<WeatherRepository>()),
          ),
          BlocProvider<ThemeBloc>(
            create: (context) => ThemeBloc(), // Providing the ThemeBloc
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: themeState.themeData, // Apply the current theme
              home: const WeatherScreen(),
            );
          },
        ),
      ),
    );
  }
}
