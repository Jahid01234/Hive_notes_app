import 'package:flutter/material.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';

class BuildBulletPoint extends StatelessWidget {
  final String text;

  const BuildBulletPoint({
    super.key,
    required this.text,
  });



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: getWidth(16),
          bottom: getHeight(6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: globalTextStyle(
              fontSize: 14,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: globalTextStyle(
                fontSize: 14,
                color: AppColors.greyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}