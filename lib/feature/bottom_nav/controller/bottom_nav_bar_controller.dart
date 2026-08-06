import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/icons_path.dart';
import 'package:hive_notes_app/feature/folder/view/folder_screen.dart';
import 'package:hive_notes_app/feature/home/view/home_screen.dart';
import 'package:hive_notes_app/feature/setting/view/setting_screen.dart';

class BottomNavBarController extends GetxController{
  var selectedIndex = 0.obs;
  final List<Map<String, String>> navItems = [
    {
      'icon': IconsPath.home,
      'title': 'Home',
    },
    {
      'icon': IconsPath.folder,
      'title': 'Folder',
    },
    {
      'icon': IconsPath.setting,
      'title': 'Setting',
    },
  ];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> pages = [
    HomeScreen(),
    FolderScreen(),
    SettingsScreen(),
  ];

}