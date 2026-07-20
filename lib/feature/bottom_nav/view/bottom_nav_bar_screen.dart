import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';
import 'package:hive_notes_app/feature/bottom_nav/controller/bottom_nav_bar_controller.dart';

class BottomNavBarScreen extends StatelessWidget {
   BottomNavBarScreen({super.key});

  final BottomNavBarController controller = Get.put(BottomNavBarController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: controller.pages[controller.selectedIndex.value],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration:  BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 2,
              spreadRadius: 0,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(0),
            _navItem(1),
            _navItem(2),
          ],
        ),
      ),
    ),
    );
  }

  // build nav item............................................................
  Widget _navItem(int index) {
    bool isSelected = controller.selectedIndex.value == index;
    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            controller.navItems[index]['icon']!,
            height: 24,
            width: 24,
            color: isSelected
                ? AppColors.blackColor
                : Colors.grey,
          ),
          const SizedBox(height: 4),
          if (isSelected)
            Text(
              controller.navItems[index]['title']!,
              style: globalTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
              ),
            ),
        ],
      ),
    );
  }
}
