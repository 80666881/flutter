import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/model/counterModel.dart';
import 'package:provider/provider.dart';

class CounterB extends StatelessWidget {
  CounterB({Key key, this.arguments}) : super(key: key);
  final Map arguments;

  @override
  Widget build(BuildContext context) {
    print('arguments_,${arguments}');
    return new Scaffold(
        appBar: AppBar(
          title: Text('page Counter B'),
        ),
        body: Center(
            child: Consumer<counterModel>(builder: (context, counter, child) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('当前的counter_${counter.value}',
                    style: TextStyle(
                        color: Color.fromRGBO(150, 100, 100, 1), fontSize: 40)),
                Text('从上级路由获取参数__${arguments["title"]}')
              ]);
        })));
  }
}
