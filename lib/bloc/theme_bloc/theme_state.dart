part of 'theme_bloc.dart';

abstract class ThemeState {
  ThemeData get themeData;
}

class LightThemeState extends ThemeState {
  @override
  ThemeData get themeData => ThemeData.light(); // Light theme
}

class DarkThemeState extends ThemeState {
  @override
  ThemeData get themeData => ThemeData.dark(); // Dark theme
}
