import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/note_model.dart';
import '../../models/user_model.dart';

class DbHelper {
  DbHelper._();

  static final DbHelper getInstances = DbHelper._();
  Database? mainDb;
  SharedPreferences? prefs;

  //tables Name
  static String table_user = 'user';
  static String table_notes = 'notes';

  //User table Columns
  static String User_Col_UID = 'uid';
  static String User_Col_Name = 'name';
  static String User_Col_Email = 'email';
  static String User_Col_Password = 'password';
  static String User_Col_Phone = 'phone';

  //notes table columns
  static String Notes_Col_NID = 'nid';
  static String Notes_Col_Title = 'title';
  static String Notes_Col_Desc = 'desc';

  Future<Database> getDb() async {
    mainDb ??= await openDb();
    return mainDb!;
  }

  Future<Database> openDb() async {
    Directory mainDirectory = await getApplicationDocumentsDirectory();
    String rootPath = join(mainDirectory.path, 'user.db');
    return openDatabase(rootPath, version: 1, onCreate: (db, version) {
      db.rawQuery('''create table $table_user (
      $User_Col_UID integer primary key autoincrement,
      $User_Col_Name text,
      $User_Col_Email text,
      $User_Col_Phone text,
      $User_Col_Password text
      )''');

      db.rawQuery('''create table $table_notes (
      $Notes_Col_NID integer primary key autoincrement,
      $Notes_Col_Title text,
      $Notes_Col_Desc desc,
      $User_Col_UID integer
      )''');
    });
  }

  Future<bool> addNoteDb({required NoteModel newNote}) async {
    var db = await getDb();
    int count = await db.insert(table_notes, newNote.toMap());
    return count > 0;
  }

  Future<bool> updateNoteDb(
      {required NoteModel newNote, required int nid}) async {
    var db = await getDb();
    int count = await db.update(table_notes, newNote.toMap(),
        where: '$Notes_Col_NID = ?', whereArgs: ['$nid']);
    return count > 0;
  }

  Future<List<NoteModel>> getNoteDb({required int uid}) async {
    var db = await getDb();
    var data = await db
        .query(table_notes, where: '$User_Col_UID = ?', whereArgs: ['$uid']);
    List<NoteModel> allNotes = [];
    for (Map<String, dynamic> eachNote in data) {
      allNotes.add(NoteModel.fromMap(eachNote));
    }
    return allNotes;
  }

  Future<bool> signUp({required UserModel newModel}) async {
    var db = await getDb();
    //check is user already exist or not using email
    bool check = await checkIfEmailExist(email: newModel.email);
    bool rowsEffected = false;
    if (!check) {
      int count = await db.insert(table_user, newModel.toMap());
      rowsEffected = count > 0;
    }
    return rowsEffected;
  }

  Future<bool> checkIfEmailExist({required String email}) async {
    var db = await getDb();
    var data = await db
        .query(table_user, where: '$User_Col_Email = ?', whereArgs: [email]);
    return data.isNotEmpty;
  }

  //login
  Future<bool> checkUserValidity(
      {required String email, required String pass}) async {
    var db = await getDb();
    var data = await db.query(
      table_user,
      where: '$User_Col_Email = ? AND $User_Col_Password = ?',
      whereArgs: [email, pass],
    );
    if (data.isNotEmpty) {
      setId(id: UserModel.fromMap(data[0]).uid!);
    }

    return data.isNotEmpty;
  }

  void setId({required int id}) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setInt("id", id);
  }

  Future<int> getUid() async {
    prefs = await SharedPreferences.getInstance();
    int id = prefs!.getInt('id')!;
    return id;
  }

  Future<List<String>> getUserDetail() async {

    var db = await getDb();
    int uid = await getUid();
    var data = await db
        .query(table_user, where: '$User_Col_UID = ?', whereArgs: ['$uid']);
    List<String> allInfo = [];
      String name = UserModel.fromMap(data[0]).name;
      String email = UserModel.fromMap(data[0]).email;
      allInfo.add(name);
      allInfo.add(email);
    return allInfo;
  }
}
