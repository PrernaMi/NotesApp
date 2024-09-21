import 'package:flutter/material.dart';
import 'package:notes_app_res/database/local/db_helper.dart';
import 'package:notes_app_res/models/note_model.dart';
import 'package:notes_app_res/provider/note_provider.dart';
import 'package:notes_app_res/provider/theme_provider.dart';
import 'package:notes_app_res/screens/add_note.dart';
import 'package:notes_app_res/start_screens/log_out_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbHelper? mainDb;
  bool? isLight;
  SharedPreferences? prefs;
  String name = "";
  String email = "";
  List<NoteModel> allNotes = [];

  @override
  void initState() {
    getUserDetail();
    context.read<NotesProvider>().getInitialNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isLight = Theme.of(context).brightness == Brightness.light;
    allNotes = context.watch<NotesProvider>().getAllNotes();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notes",
          style: TextStyle(
              fontSize: 30,
              color: isLight! ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Switch.adaptive(
              value: context.watch<ThemeProvider>().getTheme(),
              onChanged: (value) {
                context.read<ThemeProvider>().changeTheme(value: value);
              }),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.search),
          )
        ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20.0),
          child: Column(
            children: [
              /*-----Profile------*/
              Row(
                children: [
                  CircleAvatar(
                    child: Icon(Icons.account_circle),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text('${email}'), Text('${name}')],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              /*-----Setting------*/
              Row(
                children: [
                  Icon(
                    Icons.settings,
                    size: 30,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Settings"),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              /*-----Logout------*/
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return LogoutPage();
                  }));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      size: 30,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Logout"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: allNotes.length,
          itemBuilder: (_,index){
            return ListTile(
              leading: CircleAvatar(
                  child: Text('${index+1}')),
              title: Text(allNotes[index].title,style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text(allNotes[index].desc),
            );
          }),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add your note",
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: isLight! ? Colors.black : Colors.white,
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return AddNote();
          }));
        },
        child: Icon(
          Icons.add,
          color: isLight! ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  void getUserDetail() async {
    var db = DbHelper.getInstances;
    List<String> allInfo = await db.getUserDetail();
    name = allInfo[0];
    email = allInfo[1];
    setState(() {});
  }
}
