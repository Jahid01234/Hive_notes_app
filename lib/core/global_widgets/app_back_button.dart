import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';

class AppBackButton extends StatelessWidget {
  final String? title;
  final bool showBackButton;

  const AppBackButton({
    super.key,
    this.title,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showBackButton)
          GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back),
          ),

        const Spacer(),
        if (title != null)
          Text(
            title!,
            style: globalTextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),

        const Spacer(),
        const SizedBox(width: 20),
      ],
    );
  }
}