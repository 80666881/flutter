import 'package:flutter/material.dart';

class ScaffoldRoute extends StatefulWidget {
  @override
  _ScaffoldRouteState createState() => _ScaffoldRouteState();
}

class _ScaffoldRouteState extends State<ScaffoldRoute>
    with SingleTickerProviderStateMixin {
  int _seletedCurIdx = 0;
  TabController _tabController; //需要定义一个// Controller
  List tabs = ["新闻", "历史", "图片"];

  @override
  void initState() {
    super.initState();
    // 创建Controller
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener((){
      print('index,${_tabController.index}');
      _onItemTapped(_tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Scaffold route'),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.dashboard),
            onPressed: () {
              // 打开抽屉菜单
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          )
        ],
        bottom: TabBar(
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList()),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), title: Text('business')),
          BottomNavigationBarItem(
              icon: Icon(Icons.school), title: Text('school'))
        ],
        currentIndex: _seletedCurIdx,
        fixedColor: Colors.red,
        onTap: _onItemTapped,

      ),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: _onAdd),
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((e) {
          //创建3个Tab页
          return Container(
            alignment: Alignment.center,
            child: Text(e, textScaleFactor: 5),
          );
        }).toList(),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _seletedCurIdx = index;
      _tabController.index = index;
    });
  }

  void _onAdd() {}
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        "images/avatar.jpeg",
                        width: 60,
                      ),
                    ),
                  ),
                  Text(
                    "Wendux",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add account'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Manage accounts'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
