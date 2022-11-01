
import 'package:flutter/material.dart';

final ScrollController verticalController = ScrollController();
String equationInputText = "0";
String lastResult = "0";
List<String> equationTextList = List<String>.filled(1, "", growable: true);
List<String> resultTextList = List<String>.empty(growable: true);