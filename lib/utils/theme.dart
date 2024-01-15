import 'package:flutter/material.dart';

/// Define a theme for the application from which the light and dark themes will be generated.
class AppTheme {
  final Color primaryColor;
  final Color? secondaryColor;
  final Color? tertiaryColor;
  final Color? bodyColor;
  final Color? displayColor;
  final Color? darkBodyColor;
  final Color? darkDisplayColor;
  final Color? selectCountriesColor;

  const AppTheme({
    required this.primaryColor,
    this.secondaryColor,
    this.tertiaryColor,
    this.bodyColor,
    this.displayColor,
    this.darkBodyColor,
    this.darkDisplayColor,
    this.selectCountriesColor,
  });

  ColorScheme get lightColors => ColorScheme.fromSeed(
        seedColor: primaryColor,
        secondary: secondaryColor,
        tertiary: tertiaryColor,
        onBackground: bodyColor,
        onSurface: displayColor,
        background: const Color(0xFFF2F6FA),
        surface: const Color(0xFFFFFFFF),
      );

  ColorScheme get darkColors => ColorScheme.fromSeed(
        seedColor: primaryColor,
        secondary: secondaryColor,
        tertiary: tertiaryColor,
        onBackground: darkBodyColor,
        onSurface: darkDisplayColor,
      );
}

/// Available themes
class AppThemes {
  static const AppTheme blue = AppTheme(
    primaryColor: Color(0xFF1651E7),
    secondaryColor: Color(0xFFFC6C29),
    tertiaryColor: Color(0xFFe0fe55),
    bodyColor: Color(0xFF627694),
    displayColor: Color(0xFF2A333F),
    darkBodyColor: Color(0xFF627694),
    darkDisplayColor: Color(0xFF2A333F),
    selectCountriesColor: Color(0xFFFB6404),
  );
}

// class AppTheme {
//   static ThemeData appTheme = ThemeData(
//     brightness: Brightness.light,
//     primaryColor: AppColors.primaryColor,
//     indicatorColor: AppColors.bodyColor,
//     scaffoldBackgroundColor: Colors.white,
//     fontFamily: 'Roboto',
//     textTheme: const TextTheme(
//       displayLarge: TextStyle(),
//       displayMedium: TextStyle(),
//       displaySmall: TextStyle(),
//       headlineLarge: TextStyle(),
//       headlineMedium: TextStyle(),
//       headlineSmall: TextStyle(),
//       titleLarge: TextStyle(),
//       titleMedium: TextStyle(),
//       titleSmall: TextStyle(),
//       bodyLarge: TextStyle(),
//       bodyMedium: TextStyle(),
//       bodySmall: TextStyle(),
//       labelLarge: TextStyle(),
//       labelMedium: TextStyle(),
//       labelSmall: TextStyle(),
//     ),
//   );
// }

class M3FontSizess {
  static const double displayTiny = 28;
  static const double displaySmall = 36;
  static const double displayMedium = 45;
  static const double displayLarge = 57;

  static const double headlineTiny = 18;
  static const double headlineSmall = 24;
  static const double headlineMedium = 28;
  static const double headlineLarge = 32;

  static const double titleTiny = 10;
  static const double titleSmall = 14;
  static const double titleMedium = 16;
  static const double titleLarge = 22;

  static const double bodyTiny = 10;
  static const double bodySmall = 12;
  static const double bodyMedium = 14;
  static const double bodyLarge = 16;

  static const double labelTiny = 10;
  static const double labelSmall = 11;
  static const double labelMedium = 12;
  static const double labelLarge = 14;
}
