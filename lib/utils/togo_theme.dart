import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TogoTheme {
  // light theme
  static final lightTheme = ThemeData(
    primaryColor: primaryColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: true,
    fontFamily: 'Montserrat',
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color>((states) => primaryColor),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: whiteColor,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: blackColor,
        fontSize: 23, //20
      ),
      iconTheme: IconThemeData(color: blackColor),
      elevation: 0,
      actionsIconTheme: IconThemeData(color: blackColor),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: whiteColor,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    // primaryTextTheme: const TextTheme(displayLarge: TextStyle()),
  );
  // dark theme
  static final darkTheme = ThemeData(
    primaryColor: darkDisplayColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: blackColor,
    useMaterial3: true,
    fontFamily: 'Montserrat',
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.resolveWith<Color>((states) => darkDisplayColor),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: blackColor,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: whiteColor,
        fontSize: 23, //20
      ),
      iconTheme: IconThemeData(color: darkDisplayColor),
      elevation: 0,
      actionsIconTheme: IconThemeData(color: darkDisplayColor),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: blackColor,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
  );
  // colors
  // static Color lightThemeColor = Colors.red, white = Colors.white, black = Colors.black, darkThemeColor = Colors.yellow;

  static Color primaryColor = const Color(0xFF1651E7),
      secondaryColor = const Color(0xFFFC6C29),
      tertiaryColor = const Color(0xFFe0fe55),
      blackColor = const Color(0xFF000000),
      whiteColor = const Color(0xFFFFFFFF),
      bodyColor = const Color(0xFF627694),
      displayColor = const Color(0xFF2A333F),
      darkBodyColor = const Color(0xFF627694),
      darkDisplayColor = const Color(0xFF2A333F),
      selectCountriesColor = const Color(0xFFFB6404);

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
