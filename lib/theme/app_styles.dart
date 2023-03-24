import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sharing_files/theme/app_colors.dart';

TextStyle robotoStyle({
  double fontSize = 16.0,
  Color color = AppColors.textColor,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return TextStyle(
    fontFamily: GoogleFonts.aBeeZee().fontFamily,
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}
