import 'dart:ui';

class NotesFields {
  static final List<String> values = [id, profileID, title, content, color];

  static final String id = '_id';
  static final String profileID = 'profileID';
  static final String title = 'title';
  static final String content = 'content';
  static final String color = 'color';
}

class NotesModel {
  final int? id;
  final int profileID;
  final String title;
  final String content;
  final Color color;

  NotesModel({
    this.id,
    required this.profileID,
    required this.title,
    required this.content,
    required this.color,
  });

  NotesModel copyWith({int? id}) {
    return NotesModel(
      id: id ?? this.id,
      profileID: profileID,
      title: title,
      content: content,
      color: color,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NotesFields.id: id,
      NotesFields.profileID: profileID,
      NotesFields.title: title,
      NotesFields.content: content,
      NotesFields.color: color.toARGB32(),
    };
  }

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      id: json[NotesFields.id] as int?,
      profileID: json[NotesFields.profileID] as int,
      title: json[NotesFields.title] as String,
      content: json[NotesFields.content] as String,
      color: Color(json[NotesFields.color] as int),
    );
  }
}
