import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/model/counterModel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('home page'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('home Page',
                style: TextStyle(color: Colors.blue, fontSize: 30)),
            FlatButton(
              child:Text('nav to counterA',
                style: TextStyle(
                  fontSize: 30
                ),
              ),
              onPressed: () async{
                Navigator.of(context).pushNamed('/counterA');
              },
            ),
            FlatButton(
              child:Text('nav to counterB',
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              onPressed: () async{
                Navigator.of(context).pushNamed('/counterB',arguments:{'title':'从homePage携带过来的参数'});
              },
            ),
            Consumer<counterModel>(
              builder: (context,counter,child)=>Text(
                '当前value为${counter.value}',
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 30
                ),
              ),
            )
          ],
        )),
        floatingActionButton: FloatingActionButton(
            onPressed: Provider.of<counterModel>(context).increment,
            child: Icon(
              Icons.add_circle,
              size: 50,
            )),
    );
  }
}
