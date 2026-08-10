import 'package:flutter/material.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';

class BuildContactInfo extends StatelessWidget {
  final IconData icon;
  final String text;

  const BuildContactInfo({
    super.key,
    required this.icon,
    required this.text,
  });



  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: getWidth(18),
          color: AppColors.primaryColor,
        ),
        SizedBox(width: getWidth(8)),
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
    );
  }
}