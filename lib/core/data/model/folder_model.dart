import 'package:hive/hive.dart';

part 'folder_model.g.dart';

@HiveType(typeId: 1) // NoteModel এর typeId 0, তাই এটা 1
class FolderModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int colorValue;

  @HiveField(3)
  DateTime createdAt;

  FolderModel({
    required this.id,
    required this.name,
    required this.colorValue,
    required this.createdAt,
  });
}