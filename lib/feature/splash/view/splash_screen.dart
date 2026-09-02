import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_colors.dart';
import 'package:hive_notes_app/core/const/app_strings.dart';
import 'package:hive_notes_app/core/const/icons_path.dart';
import 'package:hive_notes_app/core/style/global_text_style.dart';
import 'package:hive_notes_app/feature/splash/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Spacer(),
            Column(
              children: [
                Image.asset(
                  IconsPath.appPrimaryIcon,
                  height: 130,
                  width: 120,
                  fit: BoxFit.cover,
                  color: AppColors.blackColor,
                ),
                Text(
                  AppStrings.appName,
                  style: globalTextStyle(
                    fontSize: 22,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  AppStrings.appNameSubtitle,
                  textAlign: TextAlign.center,
                  style: globalTextStyle(
                    fontSize: 15,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                const SpinKitCircle(
                  size: 50,
                  color: AppColors.blackColor,
                ),
                const SizedBox(height: 5),
                Text(
                  AppStrings.loading,
                  textAlign: TextAlign.center,
                  style: globalTextStyle(
                    fontSize: 15,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
