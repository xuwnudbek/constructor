// lib/core/themes/app_theme.dart
import 'package:flutter/material.dart';
import 'colors.dart'; // Ranglar fayliga yo'l

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: "Montserrat",
    scaffoldBackgroundColor: AppColors.secondary,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.secondary,
      primary: AppColors.primary,
    ),
    iconTheme: const IconThemeData(color: AppColors.light),
    appBarTheme: AppBarTheme(
      elevation: 20,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.secondary,
      surfaceTintColor: Colors.transparent,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        fixedSize: const Size.fromHeight(40),
      ),
    ),
    dividerTheme: const DividerThemeData(
      space: 0,
      thickness: 1,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all(AppColors.primary.withAlpha(25)),
        foregroundColor: WidgetStateProperty.all(AppColors.primary),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(150),
          ),
        ),
        iconSize: WidgetStateProperty.all(20),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    // change circularprogressindicator color default white
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
      linearMinHeight: 2,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: "Montserrat",
    scaffoldBackgroundColor: AppColors.darkSecondary,
    primaryColor: AppColors.darkPrimary,
    colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
      secondary: AppColors.darkSecondary,
      primary: AppColors.darkPrimary,
    ),
    iconTheme: const IconThemeData(color: AppColors.light),
    appBarTheme: AppBarTheme(
      elevation: 20,
      backgroundColor: AppColors.darkPrimary,
      foregroundColor: AppColors.darkSecondary,
      surfaceTintColor: Colors.transparent,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        fixedSize: const Size.fromHeight(40),
      ),
    ),
    dividerTheme: const DividerThemeData(
      space: 0,
      thickness: 1,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all(AppColors.darkPrimary.withAlpha(25)),
        foregroundColor: WidgetStateProperty.all(AppColors.darkPrimary),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(150),
          ),
        ),
        iconSize: WidgetStateProperty.all(20),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
      linearMinHeight: 2,
    ),
  );
}
