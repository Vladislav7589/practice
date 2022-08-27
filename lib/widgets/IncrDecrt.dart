

import 'package:flutter/material.dart';
import 'package:practic/styles/styles.dart';

class IncrDecr extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return IncrDecrState();
  }
}

class IncrDecrState extends State<IncrDecr> {
  late int _count;
  @override
  void initState() {
    _count = 30;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IntrinsicWidth(
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white54,
              border: Border.all(width: 2, color: Colors.lightBlue)),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  tooltip: "increment",
                  splashRadius: 25,
                  splashColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      _count++;
                    });
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.lightBlue,
                  ),
                ),
                _verticalDivider (),
                Container(
                  width: 50,
                  child: Text(
                    "$_count",
                    style: mainStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                _verticalDivider (),
                IconButton(
                    tooltip: "decrement",
                    splashRadius: 25,
                    splashColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        _count--;
                      });
                    },
                    icon: Icon(
                      Icons.remove,
                      color: Colors.lightBlue,
                    ))
              ],
            ),
          )),
    );
  }
  VerticalDivider _verticalDivider (){
    return VerticalDivider(width: 2,color: Colors.lightBlue,thickness: 2,);
  }
}