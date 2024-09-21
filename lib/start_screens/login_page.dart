import 'package:flutter/material.dart';
import 'package:notes_app_res/custom_widgets/custom_textfield.dart';
import 'package:notes_app_res/database/local/db_helper.dart';
import 'package:notes_app_res/screens/home_page.dart';
import 'package:notes_app_res/start_screens/sign_up_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLight = false;

  MediaQueryData? mqData;

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  SharedPreferences? prefs;
  int ?uid;
  @override
  void initState() {
    checkUserLogin();
    super.initState();
  }

  void checkUserLogin()async{
    prefs = await SharedPreferences.getInstance();
    uid = prefs!.getInt('id');
    if(uid == 0 || uid == null){

    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return HomePage();
      }));
    }
  }
  @override
  Widget build(BuildContext context) {
    isLight = Theme.of(context).brightness == Brightness.light;
    mqData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        centerTitle: true,
        backgroundColor: isLight ? Colors.white : Colors.black,
      ),
      backgroundColor: isLight ? Colors.white : Colors.black,
      body: SingleChildScrollView(
        child: SizedBox(
          height: mqData!.size.height,
          width: mqData!.size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 15,
                ),
                /*-----Email------*/
                CustomTextField.mTextField(
                    controller: emailController,
                    hint: "abc@gmail.com",
                    prefixIcon: Icon(Icons.person),
                    label: "Email",
                    borderRadius: 12),
                //password
                SizedBox(
                  height: 15,
                ),
                /*-----Password------*/
                CustomTextField.mTextField(
                    controller: passwordController,
                    prefixIcon: Icon(Icons.lock),
                    hint: "Enter your password",
                    label: "Password",
                    showText: true,
                    borderRadius: 12),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return SignUpPage();
                    }));
                  },
                  child: Text(
                    "Don't have an account? Sign Up!!",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      buttonPressedWork(context: context);
                    },
                    child: Text("Login"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void buttonPressedWork({required BuildContext context}) async {
    if (emailController.text.toString() == "" ||
        passwordController.text.toString() == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please fill all required fields!!!")));
    } else {
      DbHelper? db = DbHelper.getInstances;
      bool check = await db.checkUserValidity(
          email: emailController.text.toString(),
          pass: passwordController.text.toString());
      !check
          ? ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Invalid credentials!!!")))
          : Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
              return HomePage();
            }));
    }
  }
}
