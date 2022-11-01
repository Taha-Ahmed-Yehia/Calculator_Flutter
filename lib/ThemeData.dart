import 'package:calculator_app/AppManager.dart';
import 'package:flutter/material.dart';

class AppTheme {
  Color primaryColor = Colors.white;
  Color secondaryColor = Colors.white;

  Color bgColor = Colors.white;

  Color primaryTextColor = Colors.white;
  Color secondaryTextColor = Colors.white;
  Color thirdTextColor = Colors.white;
  Color clear = hexColor("#000000");

  Color settingButtonColor = Colors.white;

  void refresh() {
    ApplicationManager.instance.onThemeChangeAction.invoke();
  }
}

class LightAppTheme extends AppTheme {
  LightAppTheme() {
    primaryColor = hexColor("#C2E3FF");
    secondaryColor = hexColor("#FFFFFF");

    bgColor = hexColor("#FFFFFF");

    primaryTextColor = hexColor("#49556B");
    secondaryTextColor = hexColor("#B595F0");
    thirdTextColor = hexColor("#00aBFF");

    settingButtonColor = hexColor("#49556B");
    refresh();
  }
}

class DarkAppTheme extends AppTheme {
  DarkAppTheme() {
    primaryColor = hexColor("#2F2F4F");
    secondaryColor = hexColor("#FFFFFF");

    bgColor = hexColor("#181828");

    primaryTextColor = hexColor("#ABC4E0");
    secondaryTextColor = hexColor("#7A84BF");
    thirdTextColor = hexColor("#00aBFF");

    settingButtonColor = Colors.white;
    refresh();
  }
}

Color hexColor(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}
