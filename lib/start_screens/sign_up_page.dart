import 'package:flutter/material.dart';
import 'package:notes_app_res/database/local/db_helper.dart';
import 'package:notes_app_res/models/user_model.dart';
import 'package:notes_app_res/start_screens/login_page.dart';

import '../custom_widgets/custom_textfield.dart';

class SignUpPage extends StatelessWidget {
  bool isLight = true;
  MediaQueryData? mqData;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    isLight = Theme.of(context).brightness == Brightness.light;
    mqData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
        centerTitle: true,
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
                  "Sign up Page",
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 15,
                ),
                /*-----Name------*/
                CustomTextField.mTextField(
                    controller: nameController,
                    hint: "Enter Your Name",
                    prefixIcon: Icon(Icons.drive_file_rename_outline),
                    label: "Name",
                    borderRadius: 12),
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
                SizedBox(
                  height: 15,
                ),
                /*-----phone------*/
                CustomTextField.mTextField(
                    controller: phoneController,
                    hint: "Enter Your Number",
                    prefixIcon: Icon(Icons.phone),
                    label: "Phone Number",
                    type: TextInputType.number,
                    borderRadius: 12),
                SizedBox(
                  height: 15,
                ),
                /*-----Password------*/
                CustomTextField.mTextField(
                    controller: passwordController,
                    hint: "Enter Your Password",
                    prefixIcon: Icon(Icons.visibility_off),
                    label: "Password",
                    showText: true,
                    borderRadius: 12),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                      return LoginPage();
                    }));
                  },
                  child: Text(
                    "Already have an account? Login!!",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                /*-----Sign Up button------*/

                ElevatedButton(
                    onPressed: () async {
                      signUpButton(context: context);
                    },
                    child: Text("Sign Up"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUpButton({required BuildContext context}) async {
    if (nameController.text.toString() == "" ||
        emailController.text.toString() == "" ||
        phoneController.text.toString() == "" ||
        passwordController.text.toString() == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please fill all required fields!!!")));
    } else {
      DbHelper? db = DbHelper.getInstances;
      bool isUserExist = await db.checkIfEmailExist(
          email: emailController.text.toString());
      if (!isUserExist) {
        bool check = await db.signUp(
            newModel: UserModel(
                name: nameController.text.toString(),
                email: emailController.text.toString(),
                phone: phoneController.text.toString(),
                password: passwordController.text.toString()));
        if(check){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return LoginPage();
          }));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("User already exist!!!")));
      }
    }
  }
}
