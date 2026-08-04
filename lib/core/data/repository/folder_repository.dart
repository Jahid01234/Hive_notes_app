import 'package:hive/hive.dart';
import 'package:hive_notes_app/core/data/model/folder_model.dart';


class FolderRepository {
  final Box<FolderModel> _folderBox = Hive.box<FolderModel>('foldersBox');

  Future<void> addFolder(FolderModel folder) async {
    await _folderBox.put(folder.id, folder);
  }

  List<FolderModel> getAllFolders() {
    final list = _folderBox.values.toList();
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list;
  }

  Future<void> deleteFolder(String id) async {
    await _folderBox.delete(id);
  }

  Future<void> renameFolder(String id, String newName) async {
    final folder = _folderBox.get(id);
    if (folder != null) {
      folder.name = newName;
      await folder.save();
    }
  }

  Stream<BoxEvent> watchFolders() => _folderBox.watch();
}