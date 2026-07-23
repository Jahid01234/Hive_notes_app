import 'package:flutter/material.dart';


class NoteModel {
  final String id;
  final String title;
  final String description;
  final String date;
  final bool isNew;


  NoteModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isNew = false,
  });
}