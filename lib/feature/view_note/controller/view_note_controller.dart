import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/data/model/note_model.dart';

class ViewNoteController extends GetxController {
  final NoteModel note = Get.arguments;


  void copyNote() {
    final text = '${note.title}\n\n${note.description}';
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      'Copied',
      'Note copied to clipboard',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 1),
    );
  }
}