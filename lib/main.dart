import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_notes_app/app.dart';
import 'package:hive_notes_app/core/const/app_fonts.dart';
import 'package:hive_notes_app/core/theme/theme_controller.dart';
import 'feature/home/model/note_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  // Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>('notesBox');
  await Hive.openBox('settingsBox');
  Get.put(ThemeController());

  await AppFonts.loadGoogleFonts();
  runApp(const MyApp());
}



