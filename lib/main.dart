import 'package:flutter/material.dart';
import 'package:notes_app_res/provider/theme_provider.dart';
import 'package:notes_app_res/screens/home_page.dart';
import 'package:notes_app_res/screens/note_expanded.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) {
      return ThemeProvider();
    },
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    context.read<ThemeProvider>().getInitialTheme();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: context.watch<ThemeProvider>().getTheme()
          ? ThemeMode.dark
          : ThemeMode.light,
      home: HomePage(),
    );
  }
}
