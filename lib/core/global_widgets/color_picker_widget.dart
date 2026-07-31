import 'package:flutter/material.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';

class ColorPickerWidget extends StatelessWidget {
  final int selectedColor;
  final ValueChanged<int> onColorSelected;

  const ColorPickerWidget({
    super.key,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(44),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppColors.noteColors.length,
        itemBuilder: (context, index) {
          final color = AppColors.noteColors[index];
          final isSelected = color.value == selectedColor;

          return Padding(
            padding: EdgeInsets.only(right: getWidth(10)),
            child: GestureDetector(
              onTap: () => onColorSelected(color.value),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: getWidth(40),
                height: getWidth(40),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                           ? AppColors.primaryColor
                           : Colors.grey.withValues(alpha: 0.3),
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: isSelected
                    ? const Icon(
                         Icons.check_rounded,
                         size: 18,
                         color: AppColors.primaryColor,
                    )
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}