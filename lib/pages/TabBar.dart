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
  ScrollController _scrollController;
  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //tabController
    _tabController = new TabController(length: 6, vsync: this);
    _pageController = new PageController();
    _scrollController = new ScrollController();
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
          bottom: TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                text: 'Tabs1',
                icon: Icon(Icons.alarm),
              ),
              Tab(
                text: 'Tabs2',
                icon: Icon(Icons.alarm),
              ),
              Tab(
                text: 'Tabs3',
                icon: Icon(Icons.alarm),
              ),
              Tab(
                text: 'Tabs4',
                icon: Icon(Icons.alarm),
              ),
              Tab(
                text: 'Tabs5',
                icon: Icon(Icons.alarm),
              ),
              Tab(
                text: 'Tabs6',
                icon: Icon(Icons.alarm),
              ),
            ],
          ),
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
          builder: (context) =>
              new TabBarView(controller: _tabController, children: [
            Text('选项卡1'),
            Text('选项卡2'),
            Text('选项卡3'),
            Text('选项卡4'),
            Text('选项卡5'),
            Text('选项卡6'),
          ]),
        ));
  }
}
