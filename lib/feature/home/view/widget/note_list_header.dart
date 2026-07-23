import 'package:flutter/material.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';
import 'package:hive_notes_app/feature/home/controller/home_controller.dart';


class NoteListHeader extends StatelessWidget {
  final HomeController controller;

  const NoteListHeader({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'List Notes',
          style: globalTextStyle(
            fontSize: 18,
            color: AppColors.blackColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}