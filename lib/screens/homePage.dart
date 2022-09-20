import 'dart:async';

import 'package:flutter/material.dart';
import 'package:practic/styles/styles.dart';
import 'package:practic/styles/textBorder.dart';
import 'package:practic/widgets/IncrDecrt.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  late bool _loading;
  late double _progressValue;
  String text= "Текст";
  @override
  void initState() {
    _loading = false;
    _progressValue = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/image/28.jpg"),
              fit: BoxFit.fitHeight)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Practices"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(
                  style: raizedButtomStyle,
                  onPressed: (){
                    _getReturnedData(context);
                  }, child: Text("Погода"),),
                ElevatedButton(
                  style: raizedButtomStyle,
                  onPressed: (){
                    Navigator.pushNamed(context, '/interactionPage');
                  }, child: Text("Взаимодействие"),),
                ElevatedButton(
                  style: raizedButtomStyle,
                  onPressed: (){
                    Navigator.pushNamed(context, '/networkPage');
                  }, child: Text("Сеть"),),
                ElevatedButton(
                  style: raizedButtomStyle,
                  onPressed: (){
                    Navigator.pushNamed(context, '/inheritedPage');
                  }, child: Text("Inherited"),),
                ElevatedButton(
                  style: raizedButtomStyle,
                  onPressed: (){
                    Navigator.pushNamed(context, '/providerPage');
                  }, child: Text("Provider"),),
                ElevatedButton(
                  style: raizedButtomStyle,
                  onPressed: (){
                    Navigator.pushNamed(context, '/readWritePage');
                  }, child: Text("Чтение/запись"),),



              ],),
            SizedBox(
              height: 20,
            ),
            IncrDecr(),
            SizedBox(
              height: 20,
            ),
            Text("Returned text: $text",style: mainStyle,),
            SizedBox(
              height: 20,
            ),
            Center(
                child: _progressItem ()
            ),
          ],
        ),
        floatingActionButton: Visibility(
          visible: !_loading,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                _loading = !_loading;
                _update();
              });
            },
            child: Icon(Icons.cloud_download),
          ),
        ),
      ),
    );

  }
  void _getReturnedData (BuildContext context) async {
    Date date = Date(month: "Июль",number: 15);
    final rezult = await Navigator.pushNamed(context, '/weatherPage', arguments: {
      'name' : "Вторник",
      'user': date,
    }) as String;

    setState(() {
      text = rezult;
    });
  }

  Container _progressItem () {
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _loading
              ? Container(
            child: Column(
              children: [
                const Text(
                  "Progress...",
                  style: mainStyle,
                ),
                LinearProgressIndicator(
                  color: Colors.green,
                  value: _progressValue,
                ),
                Text(
                  "${(_progressValue * 100).round()} %",
                  style: mainStyle,
                ),
              ],
            ),
          )
              : TextBorder(
              fontFamily: "IndieFlower",
              borderWidth: 2,
              fontSize: 25,
              color: Colors.lightBlue,
              text: "Press button to download")),
    );
  }

  void _update() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _progressValue += 0.1;

        if (_progressValue.toStringAsFixed(1) == "1.0") {
          _loading = false;
          t.cancel();
          _progressValue = 0.0;
          return;
        }
      });
    });
  }
}

class Date {
  late String month;
  late int number;

  Date({
    required this.number,
    required this.month,
  });
}