import 'package:flutter/material.dart';
import 'package:notes_app_res/database/local/db_helper.dart';
import 'package:notes_app_res/provider/note_provider.dart';
import 'package:notes_app_res/provider/theme_provider.dart';
import 'package:notes_app_res/start_screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context){
      return ThemeProvider();
    }),
    ChangeNotifierProvider(create: (context){
      return NotesProvider(mainDb: DbHelper.getInstances);
    })
  ],child: MyApp(),));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    context.read<ThemeProvider>().getInitialTheme();
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
      home: SplashScreen(),
    );
  }
}
