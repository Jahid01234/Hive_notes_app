import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// Global globalTextStyle function.........
TextStyle globalTextStyle({
  double fontSize = 15.0,
  FontWeight fontWeight = FontWeight.normal,
  double lineHeight = 1.5,
  Color color = Colors.black,
  double? letterSpacing,
  TextDecoration? decoration,
}) {
  return GoogleFonts.poppins(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    height: lineHeight,
    color: color,
    letterSpacing: letterSpacing,
    decoration: decoration,
  );
}

