import 'dart:async';
import 'package:flutter/material.dart';
import 'package:notes_app_res/screens/home_page.dart';
import 'package:notes_app_res/start_screens/login_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/theme_provider.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences?prefs;
  @override
  void initState() {
    nextPage();
    context.read<ThemeProvider>().getInitialTheme();
    super.initState();
  }
  Widget page = HomePage();
   void nextPage()async{
     prefs = await SharedPreferences.getInstance();
     int uid =await prefs!.getInt('id')??0;
     if(uid == 0 || uid == null){
       page = LoginPage();
     }
     Timer(Duration(milliseconds: 400),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return page;
        }));
     });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Notes App",style: TextStyle(fontSize: 40),))
    );
  }
}