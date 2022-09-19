

import 'package:flutter/material.dart';



class InheritedPage extends StatefulWidget {
  const InheritedPage({Key? key}) : super(key: key);

  @override
  InheritedPageState createState() => InheritedPageState();
}

class InheritedPageState extends State<InheritedPage> {
  int _counter = 0;

  int get counterValue {
    return _counter;
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inherited виджет'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          MyInheritedWidget(
            myState: this,
            child:  AppRootWidget(),
          ),
        ],
      ),
    );
  }
}

class AppRootWidget extends StatelessWidget {
  const AppRootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rootWidgetState = MyInheritedWidget.of(context)!.myState;
    return Card(
      elevation: 4.0,
      child: Column(
        children: <Widget>[
          Text('Главный виджет', style: Theme.of(context).textTheme.headline4),
          Text('${rootWidgetState.counterValue}', style: Theme.of(context).textTheme.headline4),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Counter(),
              Counter(),
            ],
          ),
        ],
      ),
    );
  }
}

class Counter extends StatelessWidget {

  const Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rootWidgetState = MyInheritedWidget.of(context)!.myState;
    return Card(
      margin: const EdgeInsets.all(8),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const Text('Дочерний виджет'),
            Text('${rootWidgetState.counterValue}', style: Theme.of(context).textTheme.headline4),
            ButtonBar(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.remove),
                  color: Colors.red,
                  onPressed: () => rootWidgetState._decrementCounter(),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  color: Colors.green,
                  onPressed: () => rootWidgetState._incrementCounter(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyInheritedWidget extends InheritedWidget {
  final InheritedPageState myState;

  const MyInheritedWidget({Key? key, required Widget child, required this.myState})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return myState.counterValue != oldWidget.myState.counterValue;
  }

  static MyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }
}