
import 'package:flutter/material.dart';

class InteractionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InteractionPageState();
  }
}
class InteractionPageState extends State<InteractionPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      appBar: AppBar(title: Text("Взаимодействие",),centerTitle: true,),
      body: Center(child: Text("Hi")),);
  }
}