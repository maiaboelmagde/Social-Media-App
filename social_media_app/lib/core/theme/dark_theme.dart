import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/theme_colors.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: DarkThemeColors.background,
  colorScheme: ColorScheme.fromSeed(
    seedColor: DarkThemeColors.primary,
    primary: DarkThemeColors.primary,
    secondary: DarkThemeColors.secondary,
    background: DarkThemeColors.background,
    surface: DarkThemeColors.surface,
    brightness: Brightness.dark,
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: DarkThemeColors.surface,
    foregroundColor: DarkThemeColors.primary,
    elevation: 2,
    titleTextStyle: TextStyle(
      color: DarkThemeColors.primary,
      fontFamily: 'Pacifico',
      fontSize: 24,
      fontWeight: FontWeight.w500,
    ),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'Pacifico',
      fontSize: 32,
      color: DarkThemeColors.primary,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16,
      color: DarkThemeColors.textDark,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      color: DarkThemeColors.textLight,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      color: DarkThemeColors.primary,
      fontWeight: FontWeight.w600,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: DarkThemeColors.primary,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: DarkThemeColors.surface,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: const Color.fromARGB(255, 218, 216, 216),
      ),
    ),
    hintStyle: const TextStyle(
      fontFamily: 'Poppins',
      color: DarkThemeColors.textLight,
    ),
  ),
  iconTheme: const IconThemeData(color: DarkThemeColors.primary),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: DarkThemeColors.surface,
    selectedItemColor: DarkThemeColors.primary,
    unselectedItemColor: DarkThemeColors.textLight,
    selectedLabelStyle: TextStyle(fontFamily: 'Poppins'),
    unselectedLabelStyle: TextStyle(fontFamily: 'Poppins'),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: DarkThemeColors.primary,
      textStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: DarkThemeColors.primary,
      side: const BorderSide(color: DarkThemeColors.primary),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: DarkThemeColors.secondary,
    selectedColor: DarkThemeColors.primary,
    labelStyle: const TextStyle(
      fontFamily: 'Poppins',
      color: DarkThemeColors.white,
    ),
    secondaryLabelStyle: const TextStyle(
      fontFamily: 'Poppins',
      color: DarkThemeColors.textLight,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  dividerTheme: const DividerThemeData(
    color: Color(0xFF333333),
    thickness: 1,
    space: 32,
  ),
  cardTheme: CardThemeData(
    color: DarkThemeColors.surface,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 4,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ),
);
