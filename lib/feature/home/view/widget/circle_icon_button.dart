import 'package:flutter/material.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(getWidth(10)),
        decoration: BoxDecoration(
          color: isDark
                 ? Colors.white10
                 : AppColors.lightGreyColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: getWidth(22),
          color: isDark
                 ? AppColors.whiteColor
                 : AppColors.blackColor,
        ),
      ),
    );
  }
}