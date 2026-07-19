import 'package:flutter/material.dart';
import 'package:hive_notes_app/app.dart';
import 'package:hive_notes_app/core/const/app_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppFonts.loadGoogleFonts();
  runApp(const MyApp());
}



