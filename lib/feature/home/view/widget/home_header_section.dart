import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/const/icons_path.dart';
import 'package:hive_notes_app/core/route/app_routes.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';
import 'package:hive_notes_app/core/theme/theme_controller.dart';
import 'package:hive_notes_app/feature/home/controller/home_controller.dart';
import 'package:hive_notes_app/feature/home/view/widget/circle_icon_button.dart';

class HomeHeaderSection extends StatelessWidget {
  final HomeController homeController;
  final ThemeController themeController;

  const HomeHeaderSection({
    super.key,
    required this.homeController,
    required this.themeController,
  });


  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    IconsPath.appPrimaryIcon,
                    //height: getHeight(42),
                    width: getWidth(42),
                    fit: BoxFit.contain,
                    color: isDark
                        ? AppColors.whiteColor
                        : AppColors.blackColor,
                  ),
                  Text(
                    'My Notes',
                    style: globalTextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: isDark
                             ? AppColors.whiteColor
                             : AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: getHeight(4)),
              Obx(() => Padding(
                padding:  EdgeInsets.only(left: getWidth(8)),
                child: Text(
                    '${homeController.totalNotes} notes  • '
                        ' ${homeController.pinnedCount} pinned',
                    style: globalTextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyColor,
                    ),
                  ),
              ),
              ),
            ],
          ),
        ),

        // Search button.....................
        CircleIconButton(
          icon: Icons.search_rounded,
          onTap: () => Get.toNamed(AppRoutes.search),
        ),

        SizedBox(width: getWidth(10)),

        // Theme toggle button............
        Obx(() => CircleIconButton(
            icon: themeController.isDarkMode.value
                ? Icons.light_mode_rounded
                : Icons.dark_mode_rounded,
            onTap: () => themeController.toggleTheme(),
          ),
        ),
      ],
    );
  }
}

