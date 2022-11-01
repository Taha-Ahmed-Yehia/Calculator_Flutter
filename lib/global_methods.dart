
import 'package:math_expressions/math_expressions.dart';

import 'constants.dart';
import 'global_parameters.dart';

void calculate() {
  try {
    if (equationInputText.contains("(") && !equationInputText.contains(")")) {
      equationInputText += ")";
      equationTextList.last = equationInputText;
    }
    Parser p = Parser();
    Expression exp = p.parse(equationInputText);
    ContextModel cm = ContextModel();
    lastResult = exp.evaluate(EvaluationType.REAL, cm).toString();
    if(lastResult.contains(".")){
      List<String> isFloatingPoint = lastResult.split(".");
      if(isFloatingPoint[1] == "0"){
        lastResult = isFloatingPoint[0];
      }
    }
    resultTextList.add("= $lastResult");
  } catch (e) {
    print("Error in Calculating: $e");
    resultTextList.add("Error!");
  }
  equationInputText = "";
  equationTextList.add(equationInputText);
}

void onCalculatorButtonPressed(String buttonText) {
  print(buttonText);
  switch (buttonText) {
    case "CE":
      equationInputText = "";
      equationTextList = List<String>.filled(1, "", growable: true);
      resultTextList = List<String>.empty(growable: true);
      lastResult = "0";
      break;
    case "<--":
      if (equationInputText != "") {
        equationInputText =
            equationInputText.substring(0, equationInputText.length - 1);
        equationTextList.last = equationInputText;
      }
      break;
    case "=":
      if (equationInputText != "") {
        calculate();
      }
      break;
    case rootX:
      equationInputText += "sqrt(";
      equationTextList.last = equationInputText;
      break;
    case xPow2:
      if (equationInputText == "" && lastResult != "0") {
        equationInputText = lastResult.toString();
      }
      equationInputText += "^2";
      equationTextList.last = equationInputText;
      break;
    case xPow3:
      if (equationInputText == "" && lastResult != "0") {
        equationInputText = lastResult.toString();
      }
      equationInputText += "^3";
      equationTextList.last = equationInputText;
      break;
    case xPowN:
      if (equationInputText == "" && lastResult != "0") {
        equationInputText = lastResult.toString();
      }
      equationInputText += "^";
      equationTextList.last = equationInputText;
      break;
    case ".":
      if (equationInputText == "" ||
          !isNum(equationInputText[equationInputText.length - 1])) {
        equationInputText += "0";
      }
      equationInputText += buttonText;
      equationTextList.last = equationInputText;
      break;

    default:
      if (equationInputText == "" && isOperator(buttonText)) {
        if (lastResult != "0") {
          equationInputText = lastResult.toString();
        } else {
          equationInputText = "0";
        }
      }
      if (equationInputText == "0" && isNum(buttonText)) {
        equationInputText = "";
      }
      equationInputText += buttonText;
      equationTextList.last = equationInputText;
      break;
  }
}

bool isNum(String s) => (double.tryParse(s) != null);
bool isOperator(String btnName) {
  switch (btnName) {
    case "+":
    case "-":
    case "*":
    case "/":
    case xPowN:
    case xPow2:
    case xPow3:
    case rootX:
    case percentage:
      return true;
    default:
      return false;
  }
}

