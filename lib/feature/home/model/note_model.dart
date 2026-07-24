import 'dart:ui';

class NoteModel {
  final String? id;
  final String title;
  final String description;
  final Color color;
  final String dateTime;
  final bool isNew;


  NoteModel({
    this.id,
    required this.title,
    required this.description,
    required this.color,
    required this.dateTime,
    this.isNew = false,
  });

  // add to data map..............
  Map<String,dynamic> toMap(){
    return{
      'id': id,
      'title': title,
      'description': description,
      'color': color,
      'dateTime': dateTime,
      'isNew': isNew,
    };
  }

  // retrieve the data from map.........................
  factory NoteModel.fromMap(Map<String,dynamic> map){
    return NoteModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      color: map['color'],
      dateTime: map['dateTime'],
      isNew: map['isNew'],
    );
  }
}