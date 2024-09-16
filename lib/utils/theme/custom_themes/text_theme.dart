import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ETextTheme {
  ETextTheme._();

  static const String _fontFamily = 'Montserrat';

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: EColors.dark,
        fontFamily: _fontFamily), // Applying Montserrat
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
        color: EColors.dark,
        fontFamily: _fontFamily),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: EColors.dark,
        fontFamily: _fontFamily),
    titleLarge: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: EColors.dark,
        fontFamily: _fontFamily),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: EColors.dark,
        fontFamily: _fontFamily),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: EColors.dark,
        fontFamily: _fontFamily),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: EColors.dark,
        fontFamily: _fontFamily),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: EColors.dark,
        fontFamily: _fontFamily),
    bodySmall: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: EColors.dark.withOpacity(0.5),
        fontFamily: _fontFamily),
    labelLarge: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: EColors.dark,
        fontFamily: _fontFamily),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: EColors.dark.withOpacity(0.5),
        fontFamily: _fontFamily),
  );

  /// Customizable Dark Text Theme
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: EColors.light,
        fontFamily: _fontFamily), // Applying Montserrat
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
        color: EColors.light,
        fontFamily: _fontFamily),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: EColors.light,
        fontFamily: _fontFamily),
    titleLarge: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: EColors.light,
        fontFamily: _fontFamily),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: EColors.light,
        fontFamily: _fontFamily),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: EColors.light,
        fontFamily: _fontFamily),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: EColors.light,
        fontFamily: _fontFamily),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: EColors.light,
        fontFamily: _fontFamily),
    bodySmall: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: EColors.light.withOpacity(0.5),
        fontFamily: _fontFamily),
    labelLarge: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: EColors.light,
        fontFamily: _fontFamily),
    labelMedium: const TextStyle().copyWith(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: EColors.light.withOpacity(0.5),
      fontFamily: _fontFamily,
    ),
  );
}
