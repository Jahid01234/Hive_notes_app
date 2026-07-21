import 'package:flutter/material.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_texts.dart';
import 'package:hive_notes_app/core/const/icons_path.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              IconsPath.appPrimaryIcon,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
              color: AppColors.blackColor,
            ),
            Text(
              AppTexts.appNameShort,
              style: globalTextStyle(
                fontSize: 22,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Image.asset(
          IconsPath.search,
          height: 28,
          width: 28,
          fit: BoxFit.cover,
          color: AppColors.blackColor,
        ),
      ],
    );
  }
}
