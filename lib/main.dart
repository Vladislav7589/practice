import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practic/screens/homePage.dart';
import 'package:practic/screens/interactionPage.dart';
import 'package:practic/styles/styles.dart';
import 'package:practic/styles/textBorder.dart';
import 'package:practic/screens/weatherPage.dart';
import 'package:practic/widgets/IncrDecrt.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) =>  HomePage(),
        '/weatherPage' : (BuildContext context) =>  WeatherPage(),
        '/interactionPage' : (BuildContext context) =>  InteractionPage(),
    },
    );
  }
}
