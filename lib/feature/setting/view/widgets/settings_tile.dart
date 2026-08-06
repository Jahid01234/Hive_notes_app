import 'package:flutter/material.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;
  final bool showArrow;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.iconColor,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(getRadius(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: getHeight(10),
            horizontal: getWidth(4),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(getWidth(8)),
              decoration: BoxDecoration(
                color: (iconColor ?? AppColors.greyColor).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(getRadius(10)),
              ),
              child: Icon(
                  icon,
                  size: getWidth(20),
                  color: iconColor ?? (
                         isDark
                             ? AppColors.whiteColor
                             : AppColors.blackColor
                  ),
              ),
            ),
            SizedBox(width: getWidth(14)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: globalTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isDark
                             ? AppColors.whiteColor
                             : AppColors.blackColor,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: getHeight(2)),
                    Text(
                      subtitle!,
                      style: globalTextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null)
              trailing!
            else if (showArrow)
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.greyColor,
                size: getWidth(20),
              ),
          ],
        ),
      ),
    );
  }
}