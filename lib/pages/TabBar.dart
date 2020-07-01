import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TabBar1 extends StatefulWidget {
  @override
  _TabBarState createState() => _TabBarState();
}

class _TabBarState extends State with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //tabController
    _tabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    ///页面销毁时，销毁控制器
    _tabController.dispose();
    super.dispose();
  }

  Widget _floatingActionButton = FloatingActionButton(
    child: Icon(Icons.add),
    tooltip: "Hello",
    foregroundColor: Colors.white,
    backgroundColor: Colors.black,
    onPressed: () {
      print('1222');
    },
  );
  final Color _backgroundColor = Colors.amberAccent;
  final Widget _title = Text('tabbar');
  PageController _pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: _backgroundColor,
          title: _title,
          actions: <Widget>[
            PopupMenuButton(
              color: Colors.white,
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                    value: 'friend',
                    child: IconButton(
                      icon: Icon(Icons.face),
                    ))
              ],
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _floatingActionButton,
        bottomNavigationBar: BottomAppBar(
//          notchMargin: 10,
          color: Colors.green,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.face),
              ),
              IconButton(
                icon: Icon(Icons.alarm),
              )
            ],
          ),
        ),
        body: Builder(
            builder: (context) => new PageView(
                  controller: _pageController,
                  children: [
                    Container(
//              color: Colors.pink,
                        child: ButtonBar(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {},
                          color: Colors.yellowAccent,
                          child: Text('1112'),
                        ),
                        GestureDetector(
                            onTap: () {
                              final snackBar = new SnackBar(
                                content: Text('屏幕底部消息'),
                                backgroundColor: Colors.black,
                                action: SnackBarAction(
                                  label: '撤销',
                                  onPressed: () {},
                                ),
                                duration: Duration(milliseconds: 20000),
                              );

                              Scaffold.of(context).showSnackBar(snackBar);
                            },
                            child: Text('显示屏幕底部消息'))
                      ],
                    )),
                    Text('2222'),
                    Text('3333')
                  ],
                  onPageChanged: (index) {
                    ///页面触摸作用滑动回调，用于同步tab选中状态
                    _tabController.animateTo(index);
                  },
                )));
  }
}
