import 'package:calculator_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../AppManager.dart';
import '../global_methods.dart';
import 'common_layout.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DeskTopLayout();
}

class _DeskTopLayout extends State<DesktopLayout> {
  _DeskTopLayout() {
    ApplicationManager.instance.onThemeChangeAction.addAction(() => refresh());
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
    return RawKeyboardListener(
        autofocus: true,
        focusNode: FocusNode(),
        onKey: (event) {
          handleKeyboardInputs(event);
        },
        child: Scaffold(
            backgroundColor: ApplicationManager.instance.theme.bgColor,
            body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [topPanel(context), bottomPanel()])));
  }

  Widget bottomPanel() {
    return Expanded(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [userInputOutputText(flex: 4), standardKeyboard()]));
  }

  Expanded standardKeyboard() {
    return Expanded(
      flex: 3,
      child: Row(mainAxisSize: MainAxisSize.max, children: [
        Expanded(
            child: Column(mainAxisSize: MainAxisSize.max, children: [
          calculatorButton(xPow2, fontColor: ApplicationManager.instance.theme.secondaryTextColor),
          calculatorButton(xPow3, fontColor: ApplicationManager.instance.theme.secondaryTextColor),
          calculatorButton(xPowN, fontColor: ApplicationManager.instance.theme.secondaryTextColor),
          calculatorButton(rootX, fontColor: ApplicationManager.instance.theme.secondaryTextColor),
          calculatorButton(opBracket, fontColor: ApplicationManager.instance.theme.secondaryTextColor),
        ])),
        const Divider(height: 1),
        Expanded(
            child: Column(mainAxisSize: MainAxisSize.max, children: [
          calculatorButton(percentage, fontColor: ApplicationManager.instance.theme.secondaryTextColor),
          calculatorButton("7", fontColor: ApplicationManager.instance.theme.primaryTextColor),
          calculatorButton("4", fontColor: ApplicationManager.instance.theme.primaryTextColor),
          calculatorButton("1", fontColor: ApplicationManager.instance.theme.primaryTextColor),
          calculatorButton(clBracket, fontColor: ApplicationManager.instance.theme.secondaryTextColor),
        ])),
        const Divider(height: 1),
        Expanded(
            child: Column(mainAxisSize: MainAxisSize.max, children: [
          calculatorButton("CE", fontColor: ApplicationManager.instance.theme.thirdTextColor),
          calculatorButton("8", fontColor: ApplicationManager.instance.theme.primaryTextColor),
          calculatorButton("5", fontColor: ApplicationManager.instance.theme.primaryTextColor),
          calculatorButton("2", fontColor: ApplicationManager.instance.theme.primaryTextColor),
          calculatorButton("0", fontColor: ApplicationManager.instance.theme.primaryTextColor),
        ])),
        const Divider(height: 1),
        Expanded(
            child: Column(mainAxisSize: MainAxisSize.max, children: [
          calculatorButton("<--", fontColor: ApplicationManager.instance.theme.thirdTextColor),
          calculatorButton("9", fontColor: ApplicationManager.instance.theme.primaryTextColor),
          calculatorButton("6", fontColor: ApplicationManager.instance.theme.primaryTextColor),
          calculatorButton("3", fontColor: ApplicationManager.instance.theme.primaryTextColor),
          calculatorButton(".", fontColor: ApplicationManager.instance.theme.secondaryTextColor),
        ])),
        const Divider(height: 1),
        Expanded(
            child: Column(mainAxisSize: MainAxisSize.max, children: [
          calculatorButton("/", fontColor: ApplicationManager.instance.theme.secondaryTextColor),
          calculatorButton("*", fontColor: ApplicationManager.instance.theme.secondaryTextColor),
          calculatorButton("-", fontColor: ApplicationManager.instance.theme.secondaryTextColor),
          calculatorButton("+", fontColor: ApplicationManager.instance.theme.secondaryTextColor),
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

  void handleKeyboardInputs(RawKeyEvent event) {
    String key = event.logicalKey.keyLabel;
    if (event is RawKeyDownEvent) {
      print(key);
      setState(() {
        if (key.contains("Numpad ")) {
          key = key.replaceAll("Numpad ", "");
        }
        switch (key) {
          case "Divide":
            onCalculatorButtonPressed("/");
            break;
          case "Add":
            onCalculatorButtonPressed("+");
            break;
          case "Subtract":
            onCalculatorButtonPressed("-");
            break;
          case "Multiply":
            onCalculatorButtonPressed("*");
            break;
          case "Enter":
            onCalculatorButtonPressed("=");
            break;
          case "Decimal":
            onCalculatorButtonPressed(".");
            break;
          case "Backspace":
            onCalculatorButtonPressed("<--");
            break;
          case "^":
            onCalculatorButtonPressed(xPowN);
            break;
          case "Delete":
            onCalculatorButtonPressed("CE");
            break;
          case "(":
          case ")":
          case "-":
          case "+":
          case "%":
          case "=":
            onCalculatorButtonPressed(key);
            break;
          default:
            if (isNum(key)) {
              onCalculatorButtonPressed(key);
            }
            break;
        }
      });
    }
  }
}
