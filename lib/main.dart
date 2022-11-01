import 'package:calculator_app/constants.dart';
import 'package:calculator_app/main_screen.dart';
import 'package:flutter/material.dart';

import 'AppManager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApplicationManager.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, title: appTitle, home: MainScreen());
  }
}
