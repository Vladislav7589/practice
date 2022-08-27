import 'package:flutter/material.dart';

class TextBorder extends StatelessWidget{

  TextBorder({
    Key? key,
    required this.fontFamily,
    required this.borderWidth,
    required this.fontSize,
    required this.color,
    required this.text,
  });

  String fontFamily, text;
  double fontSize,borderWidth;
  Color color;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: fontFamily,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = borderWidth
            ..color = Colors.black,
        ),
      ),
      // Solid text as fill.
      Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: fontFamily,
          color: color,
        ),
      ),
    ],)

      ;
  }
}