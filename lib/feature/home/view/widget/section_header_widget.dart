import 'package:flutter/material.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';

class SectionHeaderWidget extends StatelessWidget {
  final String title;
  final IconData? icon;
  final int? count;

  const SectionHeaderWidget({
    super.key,
    required this.title,
    this.icon,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.only(
               bottom: getHeight(10),
               top: getHeight(6),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
                icon,
                size: getWidth(15),
                color: AppColors.primaryColor,
            ),
            SizedBox(width: getWidth(6)),
          ],
          Text(
            title,
            style: globalTextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDark
                     ? Colors.white70
                     : AppColors.blackColor.withValues(alpha: 0.7),
            ),
          ),
          if (count != null) ...[
            SizedBox(width: getWidth(6)),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: getWidth(7),
                  vertical: getHeight(1),
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(getRadius(10)),
              ),
              child: Text(
                '$count',
                style: globalTextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
          SizedBox(width: getWidth(10)),
          Expanded(
            child: Divider(
              color: isDark
                     ? Colors.white12
                     : AppColors.lightGreyColor,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}