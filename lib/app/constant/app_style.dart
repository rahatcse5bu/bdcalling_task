import 'package:flutter/material.dart';

class AppStyle {
  // Global Colors
  static const Color primaryColor = Color(0xFF6200EE);  // Replace with your primary color
  static const Color secondaryColor = Color(0xFF03DAC6);  // Replace with your secondary color
  static const Color accentColor = Color(0xFF03A9F4);  // Accent color
  static const Color backgroundColor = Color(0xFFF5F5F5);  // Background color

  // Global Text Styles
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto',  // Replace with your font family
    color: Colors.black,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto',
    color: Colors.black87,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    fontFamily: 'Roboto',
    color: Colors.black54,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    fontFamily: 'Roboto',
    color: Colors.black45,
  );

  // Global App ThemeData
  static ThemeData appTheme = ThemeData(
    primaryColor: primaryColor,
    fontFamily: 'Roboto',  // Default font family for the app
    textTheme: TextTheme(
      displayLarge: heading1,
      displayMedium: heading2,
      bodyLarge: bodyText,
      bodyMedium: caption,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accentColor).copyWith(background: backgroundColor),
  );

    // Global Text Style for Bengali text
  static const TextStyle bengaliTextStyle = TextStyle(
    fontFamily: 'SiyamRupali',  // Replace with your custom font
    fontSize: 11,  // Font size
    fontWeight: FontWeight.normal,  // Font weight
    color: Colors.white,  // Font color
  );
}
