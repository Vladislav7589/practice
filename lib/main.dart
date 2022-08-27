import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practic/styles/styles.dart';
import 'package:practic/styles/textBorder.dart';
import 'package:practic/weatherPage.dart';
import 'package:practic/widgets/IncrDecrt.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) =>  _HomePage(),
        '/weatherPage' : (BuildContext context) =>  WeatherPage(),
    },
    );
  }
}


class _HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<_HomePage> {
  late bool _loading;
  late double _progressValue;

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
                              text: "Press button to download")),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              IncrDecr(),
              RaisedButton(
                color: Colors.lightBlue,
                child: Text("Weather page",style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    Navigator.pushNamed(context, '/weatherPage');
              }
              )
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
