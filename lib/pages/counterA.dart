import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/model/counterModel.dart';
import 'package:provider/provider.dart';

class CounterA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('home page'),
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            Text('CounterA'),
            Consumer<counterModel>(builder: (context, counter, child) {
              return Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Text(
                    '当前的counter_${counter.value}',
                    style: TextStyle(
                        color: Color.fromRGBO(150, 100, 100, 1), fontSize: 50),
                  ));
            })
          ],
        )));
  }
}
