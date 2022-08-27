
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const TextStyle mainStyle = TextStyle(
      fontSize: 25,
      fontFamily: "IndieFlower",
      color: Colors.lightBlue,
      fontWeight: FontWeight.bold
);
final ButtonStyle raizedButtomStyle = ElevatedButton.styleFrom(
  onPrimary: Color.fromARGB(255, 40, 43, 40),
  primary: Color.fromARGB(255, 144, 190, 109),
  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 2),
  shadowColor: Colors.green,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);