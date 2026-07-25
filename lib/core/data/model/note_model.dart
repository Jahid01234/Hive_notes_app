import 'package:hive/hive.dart';


@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  int colorValue;

  @HiveField(4)
  String category;

  @HiveField(5)
  bool isPinned;

  @HiveField(6)
  bool isFavourite;

  @HiveField(7)
  DateTime createdAt;

  @HiveField(8)
  DateTime updatedAt;

  NoteModel({
    required this.id,
    required this.title,
    required this.description,
    this.colorValue = 0xFFFFFFFF,
    this.category = 'General',
    this.isPinned = false,
    this.isFavourite = false,
    required this.createdAt,
    required this.updatedAt,
  });

  NoteModel copyWith({
    String? title,
    String? description,
    int? colorValue,
    String? category,
    bool? isPinned,
    bool? isFavourite,
    DateTime? updatedAt,
  }) {
    return NoteModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      colorValue: colorValue ?? this.colorValue,
      category: category ?? this.category,
      isPinned: isPinned ?? this.isPinned,
      isFavourite: isFavourite ?? this.isFavourite,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}