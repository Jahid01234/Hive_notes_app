import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';

class AppBackButton extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onPressed;

  const AppBackButton({
    super.key,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: getWidth(18),
          color: isDark
              ? AppColors.whiteColor
              : AppColors.blackColor,
        ),
        onPressed: onPressed ?? () => Get.back(),
      ),
      title: Text(
        title,
        style: globalTextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: isDark
              ? AppColors.whiteColor
              : AppColors.blackColor,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}