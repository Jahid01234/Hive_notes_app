import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.cancelText = 'Cancel',
    this.confirmText = 'Delete',
    this.confirmColor = AppColors.errorColor,
  });

  final String title;
  final String content;
  final String cancelText;
  final String confirmText;
  final Color confirmColor;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Get.back();
          },
          child: Text(
            confirmText,
            style: globalTextStyle(color: confirmColor),
          ),
        ),
      ],
    );
  }
}