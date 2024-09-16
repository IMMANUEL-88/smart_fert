
import 'package:flutter/material.dart';

import 'custom_themes/appbar_theme.dart';
import 'custom_themes/bottom_sheet_theme.dart';
import 'custom_themes/checkbox_theme.dart';
import 'custom_themes/chip_theme.dart';
import 'custom_themes/outlined_button_theme.dart';
import 'custom_themes/text_field_theme.dart';
import 'custom_themes/text_theme.dart';

class EAppTheme {
  EAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: ETextTheme.lightTextTheme,
    chipTheme: EChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: EAppBarTheme.lightAppBarTheme,
    checkboxTheme: ECheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: EBottomSheetTheme.lightBottomSheetTheme,
    // elevatedButtonTheme: EElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: EOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: ETextFormFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    textTheme: ETextTheme.darkTextTheme,
    chipTheme: EChipTheme.darkChipTheme,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: EAppBarTheme.darkAppBarTheme,
    checkboxTheme: ECheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: EBottomSheetTheme.darkBottomSheetTheme,
    // elevatedButtonTheme: EElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: EOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: ETextFormFieldTheme.darkInputDecorationTheme,
  );
}
