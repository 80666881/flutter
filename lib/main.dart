import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/index.dart' show routes;
import 'model/counterModel.dart';
void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => counterModel())],
    child: MyAppHome(),
  ));
}

class MyAppHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      onGenerateRoute: (RouteSettings settings){
        return MaterialPageRoute(builder: (context){
          String routeName = settings.name;
          Map args = settings.arguments;
          print('routeName,$routeName');
          print('args,$args');
          print('routes,$routes');

          // 如果访问的路由页需要登录，但当前未登录，则直接返回登录页路由，
          // 引导用户登录；其它情况则正常打开路由。
          if(routes.containsKey(routeName)){
            var func = routes[routeName];
            return func(context,arguments:args);
          }else{
            return Text('找不到该页面');
          }
        });
      },
    );
  }
}
