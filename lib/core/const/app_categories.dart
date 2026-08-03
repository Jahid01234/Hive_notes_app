// class AppCategories {
//   AppCategories._();
//
//   static const List<String> categories = [
//     'General',
//     'Work',
//     'Personal',
//     'Study',
//     'Ideas',
//     'Important',
//     'Shopping',
//     'Travel',
//   ];
// }

import 'package:flutter/material.dart';

class CategoryData {
  final String name;
  final Color color;
  final IconData icon;

  const CategoryData({required this.name, required this.color, required this.icon});
}

class AppCategories {
  AppCategories._();

  static const List<CategoryData> categoryList = [
    CategoryData(name: 'General', color: Color(0xFFB0BEC5), icon: Icons.folder_rounded),
    CategoryData(name: 'Work', color: Color(0xFF5B8DEF), icon: Icons.work_rounded),
    CategoryData(name: 'Personal', color: Color(0xFFFF8FA3), icon: Icons.person_rounded),
    CategoryData(name: 'Study', color: Color(0xFF9B7EDE), icon: Icons.school_rounded),
    CategoryData(name: 'Ideas', color: Color(0xFFFFC252), icon: Icons.lightbulb_rounded),
    CategoryData(name: 'Important', color: Color(0xFFFF6B6B), icon: Icons.priority_high_rounded),
    CategoryData(name: 'Shopping', color: Color(0xFF63D2A5), icon: Icons.shopping_bag_rounded),
    CategoryData(name: 'Travel', color: Color(0xFF4ECDC4), icon: Icons.flight_rounded),
  ];

  // পুরনো code গুলো (যেগুলো শুধু নাম লিস্ট চায়) কাজ চালিয়ে যাবে
  static List<String> get categories => categoryList.map((e) => e.name).toList();

  static CategoryData getByName(String name) {
    return categoryList.firstWhere(
          (e) => e.name == name,
      orElse: () => categoryList.first,
    );
  }
}