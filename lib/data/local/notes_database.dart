import 'package:notes_app_task3/data/models/notes_model.dart';
import 'package:notes_app_task3/data/models/profile_model.dart';
import 'package:notes_app_task3/constant.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableProfiles(
${ProfilesFields.id} $idType,
${ProfilesFields.userName} $textType,
${ProfilesFields.gender} $textType,
${ProfilesFields.age} $integerType,
${ProfilesFields.image} TEXT
)
''');
    await db.execute('''
CREATE TABLE $tableNotes(
${NotesFields.id} $idType,
${NotesFields.profileID} $integerType,
${NotesFields.title} $textType,
${NotesFields.content} $textType,
${NotesFields.color} $integerType,
FOREIGN KEY (${NotesFields.profileID}) REFERENCES $tableProfiles(${ProfilesFields.id}) 
ON DELETE CASCADE
)
''');
  }

  // Notes CRUD Operations
  Future<NotesModel> createNote(NotesModel note) async {
    final db = await instance.database;

    final id = await db.insert(tableNotes, note.toJson());
    return note.copyWith(id: id);
  }

  Future<NotesModel> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNotes,
      columns: NotesFields.values,
      where: '${NotesFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return NotesModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<NotesModel>> readAllNotes() async {
    final db = await instance.database;

    final result = await db.query(tableNotes);

    return result.map((json) => NotesModel.fromJson(json)).toList();
  }

  Future<int> updateNote(NotesModel note) async {
    final db = await instance.database;

    return db.update(
      tableNotes,
      note.toJson(),
      where: '${NotesFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableNotes,
      where: '${NotesFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteNotesForProfile(int profileId) async {
    final db = await instance.database;

    return db.delete(
      tableNotes,
      where: '${NotesFields.profileID} = ?',
      whereArgs: [profileId],
    );
  }

  // Profile CRUD Operations
  Future<ProfileModel> createProfile(ProfileModel profile) async {
    final db = await instance.database;

    final id = await db.insert(tableProfiles, profile.toJson());
    return profile.copyWith(id: id);
  }

  Future<ProfileModel> readProfile(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableProfiles,
      columns: ProfilesFields.values,
      where: '${ProfilesFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ProfileModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<ProfileModel>> readAllProfile() async {
    final db = await instance.database;

    final result = await db.query(tableProfiles);

    return result.map((json) => ProfileModel.fromJson(json)).toList();
  }

  Future<int> updateProfile(ProfileModel profile) async {
    final db = await instance.database;

    return db.update(
      tableProfiles,
      profile.toJson(),
      where: '${ProfilesFields.id} = ?',
      whereArgs: [profile.id],
    );
  }

  Future<int> deleteProfile(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableProfiles,
      where: '${ProfilesFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
