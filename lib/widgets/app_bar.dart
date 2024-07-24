import 'package:flutter/material.dart';
import 'package:mobi_health/theme.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar appAppBar(String title) {
  return AppBar(
    backgroundColor: AppColors.backgroundColor,
    centerTitle: true,
    iconTheme: const IconThemeData(
      color: Colors.black,
      
    ),
    title: Text(
      title,
      style: GoogleFonts.openSans(
        fontSize: 26,
        color: AppColors.primary_800Color,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
