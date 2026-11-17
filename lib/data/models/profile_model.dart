import 'package:notes_app_task3/data/models/notes_model.dart';

class ProfilesFields {
  static final List<String> values = [id, userName, gender, age, image];

  static final String id = '_id';
  static final String userName = 'user_name';
  static final String gender = 'gender';
  static final String age = 'age';
  static final String image = 'image';
}

class ProfileModel {
  final int? id;
  final String userName;
  final String gender;
  final int age;
  final String? image;
  final List<NotesModel>? notes;

  ProfileModel({
    this.id,
    required this.userName,
    required this.gender,
    required this.age,
    required this.image,
    this.notes,
  });

  ProfileModel copyWith({int? id, List<NotesModel>? notes}) {
    return ProfileModel(
      id: id ?? this.id,
      userName: userName,
      gender: gender,
      age: age,
      image: image,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ProfilesFields.id: id,
      ProfilesFields.userName: userName,
      ProfilesFields.gender: gender,
      ProfilesFields.age: age,
      ProfilesFields.image: image,
    };
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json[ProfilesFields.id] as int?,
      userName: json[ProfilesFields.userName] as String,
      gender: json[ProfilesFields.gender] as String,
      age: json[ProfilesFields.age] as int,
      image: json[ProfilesFields.image] as String?,
    );
  }
}
