import 'package:get/get.dart';
import 'package:hive_notes_app/feature/bottom_nav/view/bottom_nav_bar_screen.dart';
import 'package:hive_notes_app/feature/splash/view/splash_screen.dart';

class AppRoutes {
  // Get routes name here.......
  static const String splash = '/splash';
  static const String bottomNavBar = '/bottomNavBar';



  // Get routes here.......
  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: bottomNavBar,
      page: () => BottomNavBarScreen(),
      transition: Transition.leftToRight,
    ),

  ];
}