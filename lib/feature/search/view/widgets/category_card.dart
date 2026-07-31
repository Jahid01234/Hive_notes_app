import 'package:flutter/material.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';

class CategoryCard extends StatelessWidget {
  final String category;
  final bool isDark;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.isDark,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: getWidth(8)),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
              horizontal: getWidth(14),
              vertical: getHeight(8),
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryColor
                : (isDark
                    ? Colors.white10
                    : AppColors.lightGreyColor
            ),
            borderRadius: BorderRadius.circular(
                getRadius(12),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            category,
            style: globalTextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? AppColors.whiteColor
                  : (
                      isDark
                          ? Colors.white70
                          : AppColors.blackColor
              ),
            ),
          ),
        ),
      ),
    );
  }
}
