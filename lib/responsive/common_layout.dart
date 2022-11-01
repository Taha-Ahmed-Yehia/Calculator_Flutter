import 'dart:ui';

import 'package:calculator_app/ThemeData.dart';
import 'package:calculator_app/constants.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';

import '../AppManager.dart';
import '../global_parameters.dart';

ButtonStyle elevatedButtonStyle() {
  return ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      primary: ApplicationManager.instance.theme.clear,
      elevation: 0);
}

TextStyle textStyle(Color fontColor, bool isBold) {
  return TextStyle(
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      color: fontColor,
      fontSize: fontSize,
      overflow: TextOverflow.visible);
}

TextStyle mathTextStyleSubscripts(Color fontColor, bool isBold) {
  return TextStyle(
      fontFeatures: const [FontFeature.subscripts()],
      color: fontColor,
      fontSize: fontSize,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      overflow: TextOverflow.visible);
}

TextStyle mathTextStyleSuperscripts(Color fontColor, bool isBold) {
  return TextStyle(
      color: fontColor,
      fontSize: fontSize,
      fontFeatures: const [FontFeature.superscripts()],
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      overflow: TextOverflow.visible
  );
}

Widget userInputOutputText({int flex = 1}) {
  return Expanded(
    flex: flex,
    child: SingleChildScrollView(
        reverse: true,
        controller: verticalController,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(5),
        child: Align(
          alignment: Alignment.topLeft,
          child: RichText(
              overflow: TextOverflow.visible,
              softWrap: true,
              textAlign: TextAlign.left,
              text: TextSpan(children: showScreenInfo())),
        )),
  );
}
Widget mathText(String text, String supOrLowText, String targetWord, bool isSup, TextStyle textStyle){
  return EasyRichText(
    text,
    defaultStyle: textStyle,
    patternList: [
      EasyRichTextPattern(
          targetString: supOrLowText,
          superScript: isSup,
          stringBeforeTarget: targetWord,
          matchWordBoundaries: false,
          style: textStyle
      ),
    ],
  );
}

List<TextSpan> showScreenInfo() {
  List<TextSpan> ssi = List<TextSpan>.empty(growable: true);
  int equationTextListCont = equationTextList.length;
  int resultTextListCount = resultTextList.length;
  TextStyle txtStyle = textStyle(ApplicationManager.instance.theme.secondaryTextColor, false);
  for (int i = 0; i < equationTextListCont; i++) {
    String equationTextString = equationTextList[i];
    TextSpan equationText =
        TextSpan(text: "\n$equationTextString", style: txtStyle);
    ssi.add(equationText);

    if (i < resultTextListCount) {
      TextStyle txtStyle = textStyle(ApplicationManager.instance.theme.primaryTextColor, false);
      String result = "\n${resultTextList[i]}";
      TextSpan resultText = TextSpan(text: result, style: txtStyle);
      ssi.add(resultText);
    }
  }
  return ssi;
}

Container topPanel(BuildContext context) {
  return Container(
    height: 50,
    color: ApplicationManager.instance.theme.primaryColor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            enableFeedback: false,
            splashRadius: 0.001,
            onPressed: () => _openSettingWindow(context),
            icon: Icon(Icons.settings, color: ApplicationManager.instance.theme.settingButtonColor)),
        const SizedBox(width: 5)
      ],
    ),
  );
}

_openSettingWindow(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext c) {
        return const SettingWindow();
      });
}

class CardRoute<T> extends PageRoute<T> {
  CardRoute({
    @required builder,
    RouteSettings? settings,
    bool fullscreenDialog = false,
  })  : _builder = builder,
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder _builder;

  @override
  bool get opaque => false;

  @override
  Color? get barrierColor => Colors.black54;

  @override
  String? get barrierLabel => "Popup Card Open";

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }
}

class _SettingWindow extends State<SettingWindow> {
  @override
  Widget build(BuildContext context) {
    return Wrap(alignment: WrapAlignment.center, children: <Widget>[
      Container(
          alignment: Alignment.center,
          color: ApplicationManager.instance.theme.primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Settings",
                style: textStyle(ApplicationManager.instance.theme.primaryTextColor, true),
              ),
              Row(children: <Widget>[
                Text("Light Mode",
                    style: textStyle(ApplicationManager.instance.theme.primaryTextColor, false)),
                Switch(
                    value: ApplicationManager.instance.lightTheme,
                    onChanged: (isOn) {
                      setState(() {
                        ApplicationManager.instance.lightTheme = isOn;
                        ApplicationManager.instance.lightTheme
                            ? ApplicationManager.instance.theme = LightAppTheme()
                            : ApplicationManager.instance.theme = DarkAppTheme();
                        ApplicationManager.instance.saveData();
                      });
                    })
              ])
            ],
          ))
    ]);
  }
}

class SettingWindow extends StatefulWidget {
  const SettingWindow({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SettingWindow();
  }
}
