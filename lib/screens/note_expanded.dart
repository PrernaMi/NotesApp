import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';
import 'home_page.dart';

class NoteExpand extends StatelessWidget{
  MediaQueryData? mqData;
  bool? isLight;
  @override
  Widget build(BuildContext context) {
    isLight = Theme.of(context).brightness == Brightness.light;
    mqData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
                  return HomePage();
                }));
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.arrow_back_ios_new),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.edit_note_outlined),
          )
        ],
      ),
    );
  }
}