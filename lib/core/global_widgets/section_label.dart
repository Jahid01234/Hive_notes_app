import 'package:flutter/material.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';

class SectionLabel extends StatelessWidget {
  final String text;

  const SectionLabel({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      text,
      style: globalTextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: isDark
            ? Colors.white70
            : AppColors.blackColor.withValues(alpha: 0.7),
      ),
    );
  }
}