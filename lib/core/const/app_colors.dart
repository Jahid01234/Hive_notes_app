import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand colors
  static const Color primaryColor = Color(0xFF6C5CE7);
  static const Color secondaryColor = Color(0xFFA29BFE);

  // Neutral colors
  static const Color blackColor = Color(0xFF1E1E1E);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color greyColor = Color(0xFF9E9E9E);
  static const Color lightGreyColor = Color(0xFFF5F5F5);

  // Background colors
  static const Color scaffoldLight = Color(0xFFFAFAFA);
  static const Color scaffoldDark = Color(0xFF121212);
  static const Color cardDark = Color(0xFF1E1E1E);

  // Status colors
  static const Color errorColor = Color(0xFFE74C3C);
  static const Color successColor = Color(0xFF2ECC71);
  static const Color warningColor = Color(0xFFF39C12);

  // Note card color palette
  static const List<Color> noteColors = [
    Color(0xFFFFFFFF), // white/default
    Color(0xFFFFEBEE), // light red
    Color(0xFFFFF3E0), // light orange
    Color(0xFFFFFDE7), // light yellow
    Color(0xFFE8F5E9), // light green
    Color(0xFFE0F7FA), // light cyan
    Color(0xFFE3F2FD), // light blue
    Color(0xFFF3E5F5), // light purple
    Color(0xFFFCE4EC), // light pink
    Color(0xFFEFEBE9), // light brown
  ];
}