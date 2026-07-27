import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';
import 'package:hive_notes_app/feature/home/controller/home_controller.dart';
import 'package:hive_notes_app/core/const/app_size.dart';


class NoteListHeader extends StatelessWidget {
  final HomeController controller;

  const NoteListHeader({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Expanded(
          child: Obx(() => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: FilterType.values.map((type) {
                  final isSelected = controller.currentFilter.value == type;
                  return Padding(
                    padding: EdgeInsets.only(right: getWidth(8)),
                    child: GestureDetector(
                      onTap: () => controller.changeFilter(type),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.symmetric(
                          horizontal: getWidth(14),
                          vertical: getHeight(8),
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor
                              : (isDark ? Colors.white10 : AppColors.lightGreyColor),
                          borderRadius: BorderRadius.circular(getRadius(12)),
                        ),
                        child: Text(
                          _filterLabel(type),
                          style: globalTextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? AppColors.whiteColor
                                : (isDark ? Colors.white70 : AppColors.blackColor),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        // Sort button
        PopupMenuButton<SortType>(
          icon: Icon(
            Icons.sort_rounded,
            color: isDark
                   ? AppColors.whiteColor
                   : AppColors.blackColor,
          ),
          onSelected: controller.changeSort,
          itemBuilder: (context) => [
            const PopupMenuItem(value: SortType.newest, child: Text('Newest First')),
            const PopupMenuItem(value: SortType.oldest, child: Text('Oldest First')),
            const PopupMenuItem(value: SortType.titleAZ, child: Text('Title: A-Z')),
            const PopupMenuItem(value: SortType.titleZA, child: Text('Title: Z-A')),
          ],
        ),
      ],
    );
  }

  String _filterLabel(FilterType type) {
    switch (type) {
      case FilterType.all:
        return 'All';
      case FilterType.pinned:
        return 'Pinned';
      case FilterType.favourite:
        return 'Favourite';
    }
  }
}