import 'dart:async';

import 'package:flutter/material.dart';
import 'package:practic/styles/styles.dart';
import 'package:practic/styles/textBorder.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AppState();
  }
}

class _AppState extends State<App> {
  late bool _loading;
  late double _progressValue;
  late int _count;


  @override
  void initState() {
    _loading = false;
    _progressValue = 0.0;
    _count = 30;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
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
              const Center(
                child: ImageIcon(
                  AssetImage("assets/icons/flutter.png"),
                  color: Colors.lightBlue,
                  size: 100,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
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
                          fontSize: 35,
                          color: Colors.lightBlue,
                          text: "Press button download")
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(child: Row(children: [

              ],),)
            ],
          ),
          floatingActionButton: FloatingActionButton(
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
