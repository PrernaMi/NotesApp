import 'package:flutter/material.dart';
import 'package:notes_app_res/provider/theme_provider.dart';
import 'package:notes_app_res/screens/add_note.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  bool? isLight;

  @override
  Widget build(BuildContext context) {
    isLight = Theme.of(context).brightness == Brightness.light;
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
              onChanged: (value){
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
      body: Container(),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add your note",
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: isLight! ? Colors.black : Colors.white,
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return AddNote();
          }));
        },
        child: Icon(
          Icons.add,
          color: isLight! ? Colors.white :Colors.black,
        ),
      ),
    );
  }
}
