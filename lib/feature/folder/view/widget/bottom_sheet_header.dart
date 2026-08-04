import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';

class BottomSheetHeader extends StatelessWidget {
  final VoidCallback? onClose;

  const BottomSheetHeader({
    super.key,
    this.onClose,
  });


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Container(
              width: getWidth(40),
              height: getHeight(4),
              decoration: BoxDecoration(
                color: AppColors.greyColor.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: onClose ?? () => Get.back(),
          child: Container(
            width: getWidth(28),
            height: getHeight(28),
            decoration: BoxDecoration(
              color: AppColors.greyColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.close,
              size: 18
            ),
          ),
        ),
      ],
    );
  }
}