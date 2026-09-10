import 'package:cinelens/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    primaryColor: AppColors.primary,
    brightness: .dark,
    scaffoldBackgroundColor: AppColors.darkbackground,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(
        color: Color(0xFFB0B0B0),
        fontWeight: FontWeight.w400,
      ),
      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
        (states) => TextStyle(
          // Active label matches primary or stays light for consistency
          color: states.contains(MaterialState.error)
              ? Colors.redAccent
              : states.contains(MaterialState.focused)
              ? AppColors.primary
              : const Color(0xFFB0B0B0),
          fontWeight: FontWeight.w500,
        ),
      ),
      hintStyle: const TextStyle(
        fontWeight: .w400,

        color: Color(0xFF6B6B6B),
      ), // color
      filled: true,
      fillColor: AppColors.inputBG,
      contentPadding: const EdgeInsets.all(16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppColors.primary, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
    ),
    fontFamily: 'Satoshi',

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white, // reliable
        textStyle: TextStyle(fontSize: 16, fontWeight: .w400),
        shape: RoundedRectangleBorder(borderRadius: .circular(100)),
      ),
    ),
  );
}
