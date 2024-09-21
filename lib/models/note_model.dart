import 'package:notes_app_res/database/local/db_helper.dart';

class NoteModel {
  int uid;
  String title;
  String desc;
  int? nid;

  NoteModel(
      {required this.uid, required this.title, required this.desc, this.nid});

  factory NoteModel.fromMap(Map<String, dynamic>map){
    return NoteModel(
        uid: map[DbHelper.User_Col_UID],
        title: map[DbHelper.Notes_Col_Title],
        desc: map[DbHelper.Notes_Col_Desc],
      nid: map[DbHelper.Notes_Col_NID]
    );
  }

  Map<String,dynamic> toMap(){
    return {
      DbHelper.User_Col_UID : uid,
      DbHelper.Notes_Col_Title : title,
      DbHelper.Notes_Col_Desc : desc,
    };
  }
}
