
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFAEAFF7);
  static const Color primary_800Color = Color(0xFF1B1E61);
  static const Color secondaryColor = Color(0xFFF2216E);
  static const Color accentColor = Color(0xFF371B34);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  // Add more colors as needed
}


ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primaryColor,
  textTheme: TextTheme(
    titleLarge: GoogleFonts.alegreya(
      fontSize: 40.0,
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: GoogleFonts.alegreya(
      fontSize: 24.0,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: GoogleFonts.openSans(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
    ),
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryColor,
    onPrimary: Color(0xFFF5F5F5),
    secondary: AppColors.accentColor,
    onSecondary: Colors.white, 
    error: Color(4290386458),
    onError: Color(4294967295),
    background: Colors.white,
    onBackground: Color(4294967295),
    surface: Color(4294768895),
    onSurface: Color(4279966497),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 52, vertical: 21),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          AppColors.primaryColor,
        ),
        foregroundColor: MaterialStateProperty.all<Color>(
          const Color(0xFFF5F5F5)
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          GoogleFonts.openSans(
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      )
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Color.fromRGBO(133, 133, 133, 0.3), width: 0.87),
        borderRadius: BorderRadius.circular(8.74),
      ),  
      fillColor: const Color.fromRGBO(217, 217, 217, 0.3),
      filled: true,
    )

);