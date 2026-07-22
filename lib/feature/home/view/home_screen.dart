import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/const/app_size.dart';
import 'package:hive_notes_app/feature/home/controller/home_controller.dart';
import 'package:hive_notes_app/feature/home/view/widget/custom_floating_button.dart';
import 'package:hive_notes_app/feature/home/view/widget/home_header_section.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: getHeight(50)),
              HomeHeaderSection(),
              SizedBox(height: getHeight(50)),
            ],
          ),
      ),
      floatingActionButton: CustomFloatingButton(
        onPressed: () {},
      ),
    );
  }
}
