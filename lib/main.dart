import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_notes_app/app.dart';
import 'package:hive_notes_app/core/const/app_fonts.dart';
import 'package:hive_notes_app/core/data/model/folder_model.dart';
import 'package:hive_notes_app/core/data/model/note_model.dart';
import 'package:hive_notes_app/core/theme/theme_controller.dart';
import 'package:hive_notes_app/feature/folder/controller/folder_controller.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  Hive.registerAdapter(FolderModelAdapter());
  await Hive.openBox<NoteModel>('notesBox');
  await Hive.openBox<FolderModel>('foldersBox');
  await Hive.openBox('settingsBox');

  Get.put(ThemeController());
  Get.put(FolderController(), permanent: true);

  await AppFonts.loadGoogleFonts();
  runApp(const MyApp());
}



