
import 'dart:math';
import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:practic/screens/providerPage.dart';

class ColorProvider extends ChangeNotifier {

  Color color = Colors.blue;
  bool enable = false;

  void changeColor() {
    enable != enable;
    color = Color(Random().nextInt(0xffffffff));
    notifyListeners();
  }

}