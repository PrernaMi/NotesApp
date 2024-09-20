import 'package:flutter/material.dart';
import 'package:notes_app_res/screens/home_page.dart';

class AddNote extends StatelessWidget {
  MediaQueryData? mqData;
  bool? isLight;

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();
    isLight = Theme.of(context).brightness == Brightness.light;
    mqData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isLight! ? Colors.white : Colors.black,
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
          InkWell(
            //Save your Note here
            onTap: () {},
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Text(
                "Save",
                style: TextStyle(fontSize: 17),
              )),
            ),
          )
        ],
      ),
      backgroundColor: isLight! ? Colors.white : Colors.black,
      body: Container(
        height: mqData!.size.height,
        width: mqData!.size.width,
        color: isLight! ? Colors.white : Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            children: [
              /*--------Title------*/
              TextField(
                controller: titleController,
                style: TextStyle(fontSize: 45),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Title",
                    hintStyle: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey.withOpacity(0.8))),
              ),
              /*--------Description------*/
              TextField(
                controller: descController,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Type Something....",
                    hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey.withOpacity(0.8))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
