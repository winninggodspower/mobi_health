import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFAEAFF7);
  static const Color primary_800Color = Color(0xFF1B1E61);
  static const Color primary_200Color = Color(0xFFDEE0F6);
  static const Color primary50Color = Color(0xffFBFCFE);
  static const Color primary100Color = Color(0xFFF0F1FB);
  static const Color primary_600Color = Color(0xFF4D54CE);
  static const Color primary_500Color = Color(0xFF7C81DB);
  static const Color secondaryColor = Color(0xFFF2216E);
  static const Color secondary_500Color = Color(0xFFF882AD);
  static const Color accentColor = Color(0xFF371B34);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color customWhite = Color(0xFFFBFCFE);
  static const Color gray = Color(0xFF384252);
  static const Color gray2 = Color(0xFF6E7485);
  static const Color grayLight = Color.fromRGBO(217, 217, 217, 0.3); 
  // Add more colors as needed
}


ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primaryColor,
  textTheme: TextTheme(
    titleLarge: GoogleFonts.alegreya(
      fontSize: 40.0,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: GoogleFonts.alegreya(
      fontSize: 32.0,
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: GoogleFonts.alegreya(
      fontSize: 24.0,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: GoogleFonts.openSans(
      fontSize: 16.0,
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
          const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          AppColors.primary_500Color,
        ),
        foregroundColor: MaterialStateProperty.all<Color>(
          const Color(0xFFF5F5F5)
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          GoogleFonts.alegreya(
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      )
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF8292AA), width: 0.87),
        borderRadius: BorderRadius.circular(8.74),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF8292AA), width: 0.87),
        borderRadius: BorderRadius.circular(8.74),
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
      fillColor: const Color(0xFFC8CED9),
      filled: true,
      hintStyle: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  fontSize: 15.73,
                  fontWeight: FontWeight.w400,
                  color:  Color(0xFF858585),
                ),
              ),
    )

);