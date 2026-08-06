import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:hive_notes_app/core/data/model/folder_model.dart';
import 'package:hive_notes_app/core/data/model/note_model.dart';
import 'package:hive_notes_app/core/data/repository/note_repository.dart';
import 'package:hive_notes_app/core/data/repository/folder_repository.dart';
import 'package:hive_notes_app/core/utils/snackbar_util.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';



class SettingsController extends GetxController {
  final NoteRepository _noteRepository = NoteRepository();
  final FolderRepository _folderRepository = FolderRepository();

  final RxBool isProcessing = false.obs;
  final appVersion = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadAppVersion();
  }


  Future<void> _loadAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    appVersion.value = '${info.version} (${info.buildNumber})';
  }

  // ------------------ BACKUP ------------------
  Future<void> backupNotes() async {
    try {
      isProcessing.value = true;

      final notes = _noteRepository.getAllNotes().map((n) => n.toJson()).toList();
      final folders = _folderRepository.getAllFolders().map((f) => f.toJson()).toList();

      final backupData = {
        'notes': notes,
        'folders': folders,
        'backupDate': DateTime.now().toIso8601String(),
      };

      final jsonString = jsonEncode(backupData);

      final dir = await getApplicationDocumentsDirectory();
      final fileName = 'hive_notes_backup_${DateTime.now().millisecondsSinceEpoch}.json';
      final file = File('${dir.path}/$fileName');
      await file.writeAsString(jsonString);

      await Share.shareXFiles([XFile(file.path)], text: 'Hive Notes Backup');

      SnackBarUtil.success( 'Backup completed successfully');
    } catch (e) {
      SnackBarUtil.error('Backup failed. Please try again');
    } finally {
      isProcessing.value = false;
    }
  }

  // ------------------ RESTORE ------------------
  Future<void> restoreNotes() async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result == null || result.files.single.path == null) return;

      isProcessing.value = true;

      final file = File(result.files.single.path!);
      final content = await file.readAsString();
      final data = jsonDecode(content) as Map<String, dynamic>;

      final List<dynamic> notesJson = data['notes'] ?? [];
      final List<dynamic> foldersJson = data['folders'] ?? [];

      for (final json in foldersJson) {
        final folder = FolderModel.fromJson(json as Map<String, dynamic>);
        await _folderRepository.addFolder(folder);
      }

      for (final json in notesJson) {
        final note = NoteModel.fromJson(json as Map<String, dynamic>);
        await _noteRepository.addNote(note);
      }

      SnackBarUtil.success(
        '${notesJson.length} notes and ${foldersJson.length} folders restored successfully',
      );
    } catch (e) {
      SnackBarUtil.error('Restore failed. Please check if the file is valid');
    } finally {
      isProcessing.value = false;
    }
  }

  // ------------------ CLEAR ALL DATA ------------------
  Future<void> clearAllData() async {
    try {
      isProcessing.value = true;
      await _noteRepository.clearAll();

      final folders = _folderRepository.getAllFolders();
      for (final folder in folders) {
        await _folderRepository.deleteFolder(folder.id);
      }
      SnackBarUtil.success('All data cleared successfully');
    } catch (e) {
      SnackBarUtil.error('Failed to clear data');
    } finally {
      isProcessing.value = false;
    }
  }

}