import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_categories.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';
import 'package:hive_notes_app/feature/folder/controller/folder_controller.dart';
import 'package:hive_notes_app/feature/folder/view/folder_notes_screen.dart';

class FolderScreen extends StatelessWidget {
   FolderScreen({super.key});

  final FolderController controller = Get.put(FolderController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getHeight(16)),

              // Header
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Categories',
                      textAlign: TextAlign.center,
                      style: globalTextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppColors.whiteColor : AppColors.blackColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: getHeight(16)),
              Divider(color: isDark ? Colors.white12 : AppColors.lightGreyColor),
              SizedBox(height: getHeight(12)),

              // "List Categories" + sort label
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'List Categories',
                    style: globalTextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.whiteColor : AppColors.blackColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'New',
                        style: globalTextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyColor,
                        ),
                      ),
                      SizedBox(width: getWidth(4)),
                      Icon(Icons.unfold_more_rounded, size: getWidth(16), color: AppColors.greyColor),
                    ],
                  ),
                ],
              ),
              SizedBox(height: getHeight(16)),

              // Grid of folders
              Expanded(
                child: Obx(() {
                  final categories = controller.allCategories; // সব category দেখাচ্ছি, খালি হলেও

                  if (controller.categoriesWithNotes.isEmpty) {
                    // চাইলে খালি state ও দেখাতে পারো, কিন্তু folder browse করতে দিতে সব category দেখানোই ভালো
                  }

                  return GridView.builder(
                    padding: EdgeInsets.only(bottom: getHeight(20)),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: getWidth(14),
                      mainAxisSpacing: getHeight(14),
                      childAspectRatio: 0.95,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final count = controller.noteCountFor(category.name);

                      return _FolderCard(
                        category: category,
                        noteCount: count,
                        onTap: () {
                          Get.to(() => FolderNotesScreen(category: category));
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FolderCard extends StatelessWidget {
  final CategoryData category;
  final int noteCount;
  final VoidCallback onTap;

  const _FolderCard({
    required this.category,
    required this.noteCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(getRadius(20)),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(getWidth(16)),
          decoration: BoxDecoration(
            color: category.color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(getRadius(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: getWidth(48),
                height: getWidth(48),
                decoration: BoxDecoration(
                  color: category.color,
                  borderRadius: BorderRadius.circular(getRadius(14)),
                ),
                child: Icon(category.icon, color: Colors.white, size: getWidth(24)),
              ),
              SizedBox(height: getHeight(14)),
              Text(
                category.name,
                style: globalTextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor,
                ),
              ),
              SizedBox(height: getHeight(4)),
              Text(
                '$noteCount Notes',
                style: globalTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}