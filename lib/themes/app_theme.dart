import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData buildThemeData(bool darkMode) {
    return ThemeData(
      primaryColor: Colors.amber,
      brightness: (darkMode) ? Brightness.light : Brightness.light,
      scaffoldBackgroundColor: (darkMode) ? Colors.black : Colors.white,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      fontFamily: "RobotoCondensed",
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            textStyle: const TextStyle(color: Colors.white)),
      ),
      textTheme: TextTheme(
        //Headline
        headlineLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: (darkMode) ? Colors.white : Colors.black),
        headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: (darkMode) ? Colors.white : Colors.black),
        headlineSmall: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: (darkMode) ? Colors.white : Colors.black),

        //Title
        titleLarge: TextStyle(
            fontSize: 18,
            color: (darkMode) ? Colors.white : Colors.black,
            fontWeight: FontWeight.w700),
        titleMedium: TextStyle(
            fontSize: 18,
            color: (darkMode) ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600),
        titleSmall: TextStyle(
            fontSize: 18,
            color: (darkMode) ? Colors.white : Colors.black,
            fontWeight: FontWeight.w400),

        //Display
        displayLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: (darkMode) ? Colors.white : Colors.black),
        displayMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: (darkMode) ? Colors.white : Colors.black),
        displaySmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: (darkMode) ? Colors.white : Colors.black),

        //Label
        labelLarge: TextStyle(
            fontSize: 14,
            color: (darkMode) ? Colors.white : Colors.black,
            fontWeight: FontWeight.w700),
        labelMedium: TextStyle(
            fontSize: 14,
            color: (darkMode) ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600),
        labelSmall: TextStyle(
            fontSize: 14,
            color: (darkMode) ? Colors.white : Colors.black,
            fontWeight: FontWeight.w400),

        //Body
        bodyLarge: TextStyle(
            fontSize: 12,
            color: (darkMode) ? Colors.white : Colors.black,
            fontWeight: FontWeight.w700),
        bodyMedium: TextStyle(
            fontSize: 12,
            color: (darkMode) ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600),
        bodySmall: TextStyle(
            fontSize: 12,
            color: (darkMode) ? Colors.white : Colors.black,
            fontWeight: FontWeight.w400),
      ),
      inputDecorationTheme: inputDecoration(darkMode),
      colorScheme: ThemeData()
          .colorScheme
          .copyWith(
            primary: Colors.amber,
            secondary: Colors.amber,
          )
          .copyWith(surface: (darkMode) ? Colors.black : Colors.white),
    );
  }

  static InputDecorationTheme inputDecoration(bool darkMode) {
    return InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.blueGrey.shade50, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.blueGrey.shade50, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:
            BorderSide(color: Colors.red.withValues(alpha: 0.8), width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red, width: 1.4),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.teal, width: 1),
      ),
      labelStyle: TextStyle(
        color: darkMode ? Colors.white : Colors.black,
      ),
      disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent)),
      hintStyle: TextStyle(color: Colors.blueGrey.shade400, fontSize: 12),
    );
  }
}
