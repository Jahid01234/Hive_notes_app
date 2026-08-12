import 'package:get/get.dart';
import 'package:hive_notes_app/feature/add_note/view/add_note_screen.dart';
import 'package:hive_notes_app/feature/bottom_nav/view/bottom_nav_bar_screen.dart';
import 'package:hive_notes_app/feature/edit_note/view/edit_note_screen.dart';
import 'package:hive_notes_app/feature/folder/view/folder_notes_screen.dart';
import 'package:hive_notes_app/feature/home/view/home_screen.dart';
import 'package:hive_notes_app/feature/privacy_policy/view/privacy_policy_screen.dart';
import 'package:hive_notes_app/feature/search/view/search_screen.dart';
import 'package:hive_notes_app/feature/splash/view/splash_screen.dart';
import 'package:hive_notes_app/feature/terms_conditions/view/terms_and_conditions_screen.dart';
import 'package:hive_notes_app/feature/view_note/view/view_note_screen.dart';

class AppRoutes {
  // Get routes name here.......
  static const String splash = '/splash';
  static const String bottomNavBar = '/bottomNavBar';
  static const String home = '/home';
  static const String addNote = '/addNote';
  static const String editNote = '/edit-note';
  static const String viewNote = '/viewNote';
  static const String search = '/search';
  static const String termsAndConditions = '/termsAndConditions';
  static const String privacyPolicy = '/privacyPolicy';
  static const String folderNotes = '/folderNotes';



  // Get routes here.......
  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: bottomNavBar,
      page: () => BottomNavBarScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: home,
      page: () => HomeScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: addNote,
      page: () =>  AddNoteScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: editNote,
      page: () => EditNoteScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: viewNote,
      page: () => ViewNoteScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: search,
      page: () => SearchScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: termsAndConditions,
      page: () => TermsAndConditionsScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: privacyPolicy,
      page: () => PrivacyPolicyScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: folderNotes,
      page: () => FolderNotesScreen(),
      transition: Transition.downToUp,
    ),

  ];
}