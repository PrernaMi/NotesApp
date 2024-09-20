import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/user_model.dart';

class DbHelper {
  DbHelper._();

  static final DbHelper getInstances = DbHelper._();
  Database? mainDb;
  SharedPreferences? prefs;

  //tables Name
  static String table_user = 'user';

  //User table Columns
  static String User_Col_UID = 'uid';
  static String User_Col_Name = 'name';
  static String User_Col_Email = 'email';
  static String User_Col_Password = 'password';
  static String User_Col_Phone = 'phone';

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
    });
  }

  Future<bool> signUp({required UserModel newModel}) async {
    var db = await getDb();
    //check is user already exist or not using email
    bool check = await checkUserExistence(email: newModel.email);
    bool rowsEffected = false;
    if (!check) {
      int count = await db.insert(table_user, newModel.toMap());
      rowsEffected = count > 0;
    }
    return rowsEffected;
  }

  Future<bool> checkUserExistence({required String email}) async {
    var db = await getDb();
    var data = await db
        .query(table_user, where: '$User_Col_Email = ?', whereArgs: [email]);
    return data.isNotEmpty;
  }

  //login
  Future<bool> checkUserValidity({required String email, required String pass}) async {
    var db = await getDb();
    var data = await db.query(table_user,
        where: '$User_Col_Email = ? and $User_Col_Password = ?',
        whereArgs: [email, pass]);
    if(data.isNotEmpty){
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
    int id = prefs!.getInt('theme') ?? 0;
    return id;
  }
}
