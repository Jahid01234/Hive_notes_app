import 'package:get/get.dart';
import 'package:hive_notes_app/core/route/app_routes.dart';

class SplashController extends GetxController{

  @override
  void onInit() {
    super.onInit();
    //redirectToNextScreen();
  }


  Future<void> redirectToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
     Get.offNamed(AppRoutes.bottomNavBar);
  }
}