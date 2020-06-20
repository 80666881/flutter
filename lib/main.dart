import 'package:flutter/material.dart';

void main() => runApp(FluApp());

//定义路由表
final routes = {
  '/': (context, {arguments}) => HomePage(),
  '/newRoute': (context, {arguments}) => NewRoute(),
  '/withParams': (context, {arguments}) => WithParamsRoute(arguments: arguments),
};

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Center(
            child: Text('HomePage'),
          ),
          FlatButton(
            child:Text('跳转到newRoute页'),
            onPressed:(){ Navigator.of(context).pushNamed('newRoute');},
          )
        ],
      )

    );
  }
}

class FluApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //注册路由表
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          String routeName = settings.name;
          Map args = settings.arguments;
          print('routeName,$routeName');
          print('args,$args');

          // 如果访问的路由页需要登录，但当前未登录，则直接返回登录页路由，
          // 引导用户登录；其它情况则正常打开路由。
          if(routes.containsKey(routeName)){
            var func = routes[routeName];
            return func(context);
          }else{
            return Text('找不到该页面');
          }
        });
      },
      theme: new ThemeData(primaryColor: Colors.white),
//      home: NewRoute(),
    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: new Text('new route')),
        body: Center(
            child: Column(
          children: <Widget>[
            Text('this is new route'),
            FlatButton(
              child: Text('跳转到带参路由'),
              onPressed: () async {
                Navigator.of(context).pushNamed("withPrams",
                    arguments: {'d': '222', 's': '333'});
//                Navigator.push(context,
//                  MaterialPageRoute(builder: (context) {
//                  return WithParamsRoute(
//                    text: '带参路由携带参数',
//                  );
//                }));
              },
            )
          ],
        )));
  }
}

class WithParamsRoute extends StatelessWidget {
  WithParamsRoute({Key key, this.text, this.arguments}) : super(key: key);
  final String text;
  final Map arguments;

  @override
  Widget build(BuildContext context) {
//    var args = ModalRoute.of(context).settings.arguments;
    print('arguments,$arguments');
    return new Scaffold(
      appBar: new AppBar(
        title: Text('WithParamsRoute'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(text),
            FlatButton(
              onPressed: () => Navigator.pop(context, "我是返回值"),
              child: Text("返回"),
            )
          ],
        ),
      ),
    );
  }
}
