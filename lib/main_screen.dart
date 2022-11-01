import 'package:calculator_app/AppManager.dart';
import 'package:calculator_app/responsive/desktop_layout.dart';
import 'package:calculator_app/responsive/mobile_layout.dart';
import 'package:calculator_app/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MainScreen();
  }
}

class _MainScreen extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ResponsiveLayout(desktop: DesktopLayout(), mobile: MobileLayout()));
  }
}
