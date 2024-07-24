import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget materialButton({
  required String text,
  required Color buttonBkColor,
  required Color textColor,
  required VoidCallback onPres,
  double size = 19,
  double borderRadiusSize = 18.0,
  double? width,
  double? height,
}) {
  return SizedBox(
    width: width,
    height: height,
    child: MaterialButton(
      onPressed: onPres,
      color: buttonBkColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusSize),
      ),
      child: Text(
        text,
        style: GoogleFonts.openSans(
          fontSize: size,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}