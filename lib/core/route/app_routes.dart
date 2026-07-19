import 'package:get/get.dart';
import 'package:hive_notes_app/feature/splash/view/splash_screen.dart';

class AppRoutes {
  // Get routes name here.......
  static const String splash = '/splash';



  // Get routes here.......
  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
      transition: Transition.leftToRight,
    ),

  ];
}