import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';
import 'package:hive_notes_app/feature/folder/controller/folder_controller.dart';

class CategoryChipWidget extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  CategoryChipWidget({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final FolderController folderController = Get.find<FolderController>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(() {
      final categories = folderController.categoryOptions;
      return SizedBox(
        height: getHeight(38),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final isSelected = category == selectedCategory;

            return Padding(
              padding: EdgeInsets.only(right: getWidth(8)),
              child: GestureDetector(
                onTap: () => onCategorySelected(category),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                    horizontal: getWidth(16),
                    vertical: getHeight(8),
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryColor
                        : (isDark ? Colors.white10 : AppColors.lightGreyColor),
                    borderRadius: BorderRadius.circular(getRadius(20)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    category,
                    style: globalTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? AppColors.whiteColor
                          : (isDark ? Colors.white70 : AppColors.blackColor),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}