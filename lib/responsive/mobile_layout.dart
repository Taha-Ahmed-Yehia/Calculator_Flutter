import 'package:calculator_app/AppManager.dart';
import 'package:calculator_app/constants.dart';
import 'package:flutter/material.dart';
import '../global_methods.dart';
import 'common_layout.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MobileLayout();
}

class _MobileLayout extends State<MobileLayout> {
  _MobileLayout() {
    ApplicationManager.instance.onThemeChangeAction.addAction(refresh);
  }

  refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    ApplicationManager.instance.onThemeChangeAction.removeAction(() => refresh());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ApplicationManager.instance.theme.bgColor,
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [topPanel(context), bottomPanel()])));
  }

  Widget bottomPanel() {
    return Expanded(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [userInputOutputText(), standardKeyboard()]));
  }

  Expanded standardKeyboard() {
    return Expanded(
      child: Column(mainAxisSize: MainAxisSize.max, children: [
        Expanded(
            child: Row(mainAxisSize: MainAxisSize.max, children: [
          calculatorButton(xPowN, fontColor: ApplicationManager.instance.theme.secondaryTextColor),
          calculatorButton(rootX, fontColor: ApplicationManager.instance.theme.secondaryTextColor),
          calculatorButton("CE", fontColor: ApplicationManager.instance.theme.thirdTextColor),
          calculatorButton("<--", fontColor: ApplicationManager.instance.theme.thirdTextColor),
        ])),
        const Divider(height: 1),
        Expanded(
            child: Row(mainAxisSize: MainAxisSize.max, children: [
          calculatorButton(xPow2, fontColor: ApplicationManager.instance.theme.secondaryTextColor),
          calculatorButton(opBracket, fontColor: ApplicationManager.instance.theme.secondaryTextColor),
          calculatorButton(clBracket, fontColor: ApplicationManager.instance.theme.secondaryTextColor),
          calculatorButton("/", fontColor: ApplicationManager.instance.theme.secondaryTextColor),
        ])),
        const Divider(height: 1),
        Expanded(
            child: Row(mainAxisSize: MainAxisSize.max, children: [
          calculatorButton("7", fontColor: ApplicationManager.instance.theme.primaryTextColor),
          calculatorButton("8", fontColor: ApplicationManager.instance.theme.primaryTextColor),
          calculatorButton("9", fontColor: ApplicationManager.instance.theme.primaryTextColor),
          calculatorButton("*", fontColor: ApplicationManager.instance.theme.secondaryTextColor),
        ])),
        const Divider(height: 1),
        Expanded(
            child: Row(mainAxisSize: MainAxisSize.max, children: [
          calculatorButton("4", fontColor: ApplicationManager.instance.theme.primaryTextColor),
          calculatorButton("5", fontColor: ApplicationManager.instance.theme.primaryTextColor),
          calculatorButton("6", fontColor: ApplicationManager.instance.theme.primaryTextColor),
          calculatorButton("-", fontColor: ApplicationManager.instance.theme.secondaryTextColor),
        ])),
        const Divider(height: 1),
        Expanded(
            child: Row(mainAxisSize: MainAxisSize.max, children: [
          calculatorButton("1", fontColor: ApplicationManager.instance.theme.primaryTextColor),
          calculatorButton("2", fontColor: ApplicationManager.instance.theme.primaryTextColor),
          calculatorButton("3", fontColor: ApplicationManager.instance.theme.primaryTextColor),
          calculatorButton("+", fontColor: ApplicationManager.instance.theme.secondaryTextColor),
        ])),
        const Divider(height: 1),
        Expanded(
            child: Row(mainAxisSize: MainAxisSize.max, children: [
          calculatorButton(percentage, fontColor: ApplicationManager.instance.theme.secondaryTextColor),
          calculatorButton("0", fontColor: ApplicationManager.instance.theme.primaryTextColor),
          calculatorButton(".", fontColor: ApplicationManager.instance.theme.secondaryTextColor),
          calculatorButton("=", fontColor: ApplicationManager.instance.theme.thirdTextColor),
        ])),
        const Divider(height: 1),
      ]),
    );
  }

  Widget calculatorButton(String buttonText,
      {Color fontColor = Colors.white, bool isBold = false}) {
    Widget iconOrText;
    TextStyle myTextStyle = textStyle(fontColor, isBold);
    String btnText = buttonText;
    switch (btnText) {
      case "<--":
        iconOrText = Icon(Icons.backspace_outlined, color: fontColor);
        break;
      default:
        if (btnText.contains("^")) {
          String text = btnText.replaceAll("^", "");
          String targetText = btnText.substring(0, buttonText.indexOf("^"));
          String supText = btnText.substring(buttonText.indexOf("^") + 1);
          //print("$btnText: $targetText, $supText");
          iconOrText = mathText(text, supText, targetText, true, myTextStyle);
        }else{
          iconOrText = Text(btnText, style: myTextStyle, textAlign: TextAlign.center);
        }
        break;
    }
    return Expanded(
        child: Padding(
            padding: const EdgeInsets.all(4),
            child: MaterialButton(
                color: ApplicationManager.instance.theme.bgColor,
                splashColor: ApplicationManager.instance.theme.bgColor,
                highlightColor: ApplicationManager.instance.theme.primaryColor,
                hoverColor: ApplicationManager.instance.theme.bgColor,
                elevation: 0,
                onPressed: () =>
                    setState(() => onCalculatorButtonPressed(buttonText)),
                child: SizedBox.expand(child: FittedBox(child: iconOrText)))));
  }
}
