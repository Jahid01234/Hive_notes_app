import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/route/app_routes.dart';
import 'package:hive_notes_app/core/theme/app_theme.dart';
import 'package:hive_notes_app/core/theme/theme_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return GetBuilder<ThemeController>(
          builder: (themeController) {
            return GetMaterialApp(
              title: 'Notes App',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeController.themeMode,
              initialRoute: AppRoutes.splash,
              getPages: AppRoutes.routes,
            );
          },
        );
      },
    );
  }
}