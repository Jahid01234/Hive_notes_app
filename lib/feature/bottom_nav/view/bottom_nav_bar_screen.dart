import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';
import 'package:hive_notes_app/feature/bottom_nav/controller/bottom_nav_bar_controller.dart';

class BottomNavBarScreen extends StatelessWidget {
   BottomNavBarScreen({super.key});

  final BottomNavBarController controller = Get.put(BottomNavBarController());

   @override
   Widget build(BuildContext context) {
     final isDark = Theme.of(context).brightness == Brightness.dark;
     final bottomSafeArea = MediaQuery.of(context).padding.bottom;

     return Obx(() => Scaffold(
       body: controller.pages[controller.selectedIndex.value],
         bottomNavigationBar: Container(
           padding: EdgeInsets.only(
             top: getHeight(14),
             bottom: getHeight(14) + bottomSafeArea,
           ),
           decoration: BoxDecoration(
             color: isDark
                    ? AppColors.blackColor
                    : AppColors.whiteColor,
             boxShadow: [
               BoxShadow(
                 color: Colors.black.withValues(alpha: 0.05),
                 blurRadius: 4,
                 spreadRadius: 0,
                 offset: const Offset(0, 0),
               ),
             ],
           ),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: List.generate(
               controller.navItems.length,
                   (index) => _navItem(context, index, isDark),
             ),
           ),
         ),
       ),
     );
   }


   // build nav item............................................................
   Widget _navItem(BuildContext context, int index, bool isDark) {
     final bool isSelected = controller.selectedIndex.value == index;
     final Color activeColor = isDark ? AppColors.whiteColor : AppColors.blackColor;
     final Color inactiveColor = AppColors.greyColor;

     return Material(
       color: Colors.transparent,
       child: InkWell(
         borderRadius: BorderRadius.circular(getRadius(12)),
         onTap: () => controller.changeIndex(index),
         child: Padding(
           padding: EdgeInsets.symmetric(
                     horizontal: getWidth(14),
                     vertical: getHeight(4),
           ),
           child: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               Image.asset(
                 controller.navItems[index]['icon']!,
                 height: getWidth(24),
                 width: getWidth(24),
                 color: isSelected ? activeColor : inactiveColor,
               ),
               SizedBox(height: getHeight(4)),
               AnimatedSize(
                 duration: const Duration(milliseconds: 10),
                 child: isSelected
                     ? Text(
                        controller.navItems[index]['title']!,
                         style: globalTextStyle(
                           fontSize: 11,
                           fontWeight: FontWeight.w600,
                           color: activeColor,
                         ),
                   )
                     : const SizedBox.shrink(),
               ),
             ],
           ),
         ),
       ),
     );
   }
}
