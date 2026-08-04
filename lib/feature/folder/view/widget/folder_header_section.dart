import 'package:flutter/material.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';

class FolderHeaderSection extends StatelessWidget {
  final bool isDark;
  final String title;
  final VoidCallback onAddTap;

  const FolderHeaderSection({
    super.key,
    required this.isDark,
    required this.onAddTap,
    this.title = 'Folders',
  });


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Text(
          title,
          style: globalTextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: isDark
                ? AppColors.whiteColor
                : AppColors.blackColor,
          ),
        ),
        const Spacer(),
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: onAddTap,
          child: Container(
            padding: EdgeInsets.all(getWidth(4)),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isDark
                    ? Colors.white24
                    : AppColors.blackColor,
              ),
            ),
            child: Icon(
              Icons.add_rounded,
              size: getWidth(22),
              color: isDark
                  ? AppColors.whiteColor
                  : AppColors.blackColor,
            ),
          ),
        ),
      ],
    );
  }
}