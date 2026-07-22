import 'package:flutter/material.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';

class CustomFloatingButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomFloatingButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.blackColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      onPressed: onPressed,
      child: const Icon(
        Icons.add,
        size: 30,
        color: AppColors.whiteColor,
      ),
    );
  }
}