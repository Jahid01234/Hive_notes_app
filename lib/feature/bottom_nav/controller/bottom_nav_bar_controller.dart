import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/icons_path.dart';

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
    Center(child: Text("Home")),
    Center(child: Text("Folder")),
    Center(child: Text("Setting")),
  ];

}