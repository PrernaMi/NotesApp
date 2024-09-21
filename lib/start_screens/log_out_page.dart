import 'package:flutter/material.dart';
import 'package:notes_app_res/start_screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutPage extends StatefulWidget{
  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {

  SharedPreferences? prefs;
  @override
  void initState() {
    logout();
    super.initState();
  }
  void logout()async{
    prefs = await SharedPreferences.getInstance();
    prefs!.setInt('id', 0);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return LoginPage();
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LogOut page"),
        centerTitle: true,
      ),
    );
  }
}