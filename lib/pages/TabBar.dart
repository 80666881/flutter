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
  int _curIdx = 1;
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
                      onPressed: (){},
                      icon: Icon(Icons.face),
                    ))
              ],
            )
          ],

        ),
        bottomNavigationBar:BottomNavigationBar(
          currentIndex: _curIdx,
          type:BottomNavigationBarType.fixed,
          onTap: (int idx) {
            setState(() {
              _curIdx = idx;
            });
          },
          //选中的颜色
          fixedColor: Colors.red,
          items: [
            BottomNavigationBarItem(
                title:Text('聊天'),
                icon:Icon(Icons.chat)
            ),
            BottomNavigationBarItem(
                title:Text('朋友圈'),
                icon:Icon(Icons.child_friendly)
            ),
            BottomNavigationBarItem(
                title:Text('我的'),
                icon:Icon(Icons.person)
            )
          ],
        ),
        body: Builder(
          builder: (context) =>Container(

          )
        ));
  }
}
