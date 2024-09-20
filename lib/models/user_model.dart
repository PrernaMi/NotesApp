import 'package:notes_app_res/database/local/db_helper.dart';

class UserModel {
  int? uid;
  String name;
  String email;
  String password;
  String phone;

  UserModel({this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.password});


  factory UserModel.fromMap(Map<String, dynamic>map){
    return UserModel(
        uid: map[DbHelper.User_Col_UID],
        name: map[DbHelper.User_Col_Name],
        email: map[DbHelper.User_Col_Email],
        phone: map[DbHelper.User_Col_Phone],
        password: map[DbHelper.User_Col_Password]
    );
  }

  //we will not add uid because this will used when we have to
  //add data in database but in database uid is autoincrement
  Map<String, dynamic> toMap() {
    return {
      DbHelper.User_Col_Name : name,
      DbHelper.User_Col_Email : email,
      DbHelper.User_Col_Phone :phone,
      DbHelper.User_Col_Password : password
    };
  }
}
