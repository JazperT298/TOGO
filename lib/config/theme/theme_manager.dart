import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/theme.dart';

/// Manage theme across the app.
class ThemeManager {
  ThemeManager({AppTheme? defaultTheme, ThemeMode? themeMode}) {
    _currentTheme = defaultTheme ?? AppThemes.blue;
    _themeMode = themeMode ?? ThemeMode.system;
  }

  late AppTheme _currentTheme;
  late ThemeMode _themeMode;

  ThemeData get darkTheme => _buildTheme(_currentTheme.darkColors);
  ThemeData get lightTheme => _buildTheme(_currentTheme.lightColors);
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleDarkMode() => _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
  void resetSystemThemeMode() => _themeMode = ThemeMode.system;
  void switchTheme(AppTheme newTheme) => _currentTheme = newTheme;

  Color? get bodyColor => isDarkMode ? _currentTheme.darkBodyColor : _currentTheme.bodyColor;
  Color? get displayColor => isDarkMode ? _currentTheme.darkDisplayColor : _currentTheme.displayColor;

  ThemeData _buildTheme(ColorScheme colorScheme) => ThemeData.from(
      colorScheme: colorScheme,
      textTheme: GoogleFonts.spaceGroteskTextTheme()
          .copyWith(
            headlineSmall: buildHeadlineTextStyle(from: const TextStyle(fontSize: M3FontSizes.headlineSmall)),
            headlineMedium: buildHeadlineTextStyle(from: const TextStyle(fontSize: M3FontSizes.headlineMedium)),
            headlineLarge: buildHeadlineTextStyle(from: const TextStyle(fontSize: M3FontSizes.headlineLarge)),
          )
          .apply(bodyColor: bodyColor, displayColor: displayColor));

  /// Define the [TextStyle] for headlines.
  /// [textStyle] define the style to merge with.
  TextStyle buildHeadlineTextStyle({TextStyle? from}) => GoogleFonts.inter(textStyle: from, fontWeight: FontWeight.bold, color: displayColor);
}
