## 路由

### 在routes/index中定义各个route对应的组件

```dart
final routes = {
  '/': (context, {arguments}) => HomePage(),
  //不带参数路由
  '/counterA': (context, {arguments}) => CounterA(),
  //带参数路由
  '/counterB':(context, {arguments}) => CounterB(arguments: arguments)
};
```

### 在主入口不再定义body和title，交由onGenerateRoute处理

每个路由都会经过onGenerateRoute处理，settings可以拿到路由参数，这里可以做参数传递，路由鉴权
注意对于需要传参的路由，要加入arguments:args（```func(context,arguments:args```);）
```dart
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
```


### 页面组件arguments参数添加

在页面组件通过定义arguments传入参数

```dart
class CounterB extends StatelessWidget {
  CounterB({Key key, this.arguments}) : super(key: key);
  final Map arguments;
  //使用时直接获取，比如
  arguments["title"]
}
```


## 全局provider

flutter状态管理采用provider


### Model


#### Model定义

```dart
class CounterModel with ChangeNotifier {
  int value = 0;

  void increment() {
    value += 1;
    notifyListeners();
  }
}
```



#### Model创建


用ChangeNotifierProvider可以创建一个Model，注入给child组件

```dart
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterModel(),
      child: MyApp(),
    ),
  );
}
```


**多个model用multiProvider的情况**


```dart
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        Provider(create: (context) => SomeOtherClass()),
      ],
      child: MyApp(),
    ),
  );
}
```


### Consumer调用Model数据(Model->UI)


调用数据需要使用Consumer这个Widget,在泛型中定义需要查找的Model,调用其builder方法获取上下文


当 `ChangeNotifier` 发生变化的时候会调用 builder 这个函数。（换言之，当你在模型中调用 `notifyListeners()` 时，所有和 `Consumer` 相关的 builder 方法都会被调用。）


最好能把 `Consumer` 放在 widget 树尽量低的位置上。你总不希望 UI 上任何一点小变化就全盘重新构建 widget 吧。

```dart
body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Consumer<CounterModel>(
        builder: (context, counter, child) => Text(
          '${counter.value}',
          style: Theme.of(context).textTheme.headline,
        ),
      ),
    ],
  ),
),
```


### Provider.of直接调用Model数据



访问Model，不需要更改UI


有的时候你不需要模型中的 **数据** 来改变 UI，但是你可能还是需要访问该数据。比如，`ClearCart` 按钮能够清空购物车的所有商品。它不需要显示购物车里的内容，只需要调用 `clear()` 方法。

我们可以使用 `Consumer<CartModel>` 来实现这个效果，不过这么实现有点浪费。因为我们让整体框架重构了一个无需重构的 widget。

```dart
Provider.of<CartModel>(context, listen: false).removeAll();
```


在 build 方法中使用上面的代码，当 `notifyListeners` 被调用的时候，并不会使 widget 被重构。

### 为什么不建议直接用provider.of来改变UI


因为通过Consumer我们可以控制更新的颗粒度，对于不会导致组件的全部更新


比如下面的组件，每次依赖的model更新都会导致整个组件更新，如果我们用Consumer就可以避免这种情况

```dart
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _counter = Provider.of<CounterModel>(context);
    final textSize = Provider.of<int>(context).toDouble();

    return Scaffold(
      appBar: AppBar(
        title: Text('FirstPage'),
      ),
      body: Center(
        child: Text(
          'Value: ${_counter.value}',
          style: TextStyle(fontSize: textSize),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SecondPage())),
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}

```






#### Consumer


```dart
class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Consumer2<CounterModel,int>(
        builder: (context, CounterModel counter, int textSize, _) => Center(
              child: Text(
                'Value: ${counter.value}',
                style: TextStyle(
                  fontSize: textSize.toDouble(),
                ),
              ),
            ),
      ),
      floatingActionButton: Consumer<CounterModel>(
        builder: (context, CounterModel counter, child) => FloatingActionButton(
              onPressed: counter.increment,
              child: child,
            ),
        child: Icon(Icons.add),
      ),
    );
  }
}
```

