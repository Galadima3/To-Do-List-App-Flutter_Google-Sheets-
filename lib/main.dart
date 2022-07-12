import 'package:flutter/material.dart';
import 'package:flutter_gsheet/google_sheets_api.dart';

import 'package:flutter_gsheet/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleSheetsApi().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      theme: ThemeData(primarySwatch: Colors.pink),
    );
  }
}
