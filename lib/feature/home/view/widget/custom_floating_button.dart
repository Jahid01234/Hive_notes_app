import 'package:flutter/material.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';

class CustomFloatingButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomFloatingButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: AppColors.primaryColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(getRadius(100)),
      ),
      child: Icon(
              Icons.add_rounded,
              color: AppColors.whiteColor,
              size: 28,
      ),
    );
  }
}

