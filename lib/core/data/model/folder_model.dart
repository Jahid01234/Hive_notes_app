import 'package:hive/hive.dart';

part 'folder_model.g.dart';

@HiveType(typeId: 1)
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

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'colorValue': colorValue,
    'createdAt': createdAt.toIso8601String(),
  };

  factory FolderModel.fromJson(Map<String, dynamic> json) => FolderModel(
    id: json['id'],
    name: json['name'],
    colorValue: json['colorValue'],
    createdAt: DateTime.parse(json['createdAt']),
  );
}