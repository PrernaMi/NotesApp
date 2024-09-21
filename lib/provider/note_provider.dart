import 'package:flutter/material.dart';
import 'package:notes_app_res/database/local/db_helper.dart';
import 'package:notes_app_res/models/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesProvider extends ChangeNotifier{

  DbHelper? mainDb;
  NotesProvider({required this.mainDb});

  List<NoteModel> allNotes = [];
  SharedPreferences? prefs;


  void addNoteProvider({required NoteModel newNote})async{
    bool check = await mainDb!.addNoteDb(newNote: newNote);
    int uid = await mainDb!.getUid();
    if(check){
      allNotes = await mainDb!.getNoteDb(uid: uid);
      notifyListeners();
    }
  }

  void updateNoteProvider({required NoteModel newNote})async{
    bool check = await mainDb!.updateNoteDb(newNote: newNote, nid: newNote.nid!);
    int uid = await mainDb!.getUid();
    if(check){
      allNotes = await mainDb!.getNoteDb(uid: uid);
      notifyListeners();
    }
  }

  List<NoteModel> getAllNotes(){
    return allNotes;
  }

  void getInitialNotes()async{
    int uid = await mainDb!.getUid();
    allNotes = await mainDb!.getNoteDb(uid: uid);
    notifyListeners();
  }

}