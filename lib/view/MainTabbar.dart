import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gitmob/view/UserView.dart';
import 'package:after_layout/after_layout.dart';
//import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
//import 'package:zzb/View/Home/HomeView.dart';

class MainTabbarController extends StatefulWidget {
  @override
  _MainTabbarControllerState createState() => _MainTabbarControllerState();
}

class _MainTabbarControllerState extends State<MainTabbarController> {
  @override
  Widget build(BuildContext context) {
    return new CupertinoApp(
      home: new MainTabbar(),
//      routes: {
//        "/": (_) => new MainTabbarController(),
//        "/webWidget": (_) => new WebviewScaffold(
//          url: "https://www.google.com",
//          appBar: new AppBar(
//            title: new Text("Widget webview"),
//          ),
//        ),
//      },
    );
  }
}

class MainTabbar extends StatefulWidget {
  @override
  _MainTabbarState createState() => _MainTabbarState();
}

class _MainTabbarState extends State<MainTabbar> with AfterLayoutMixin<MainTabbar>{
  var _currentIndex = 0;
  
  var _contentView;

  var _firstView;// = Text("Main");
  var _secondView;// = UserView();

  var _appBar = new CupertinoNavigationBar(
    middle: Text(
      "HOME",
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.brown,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstView = Text("Main");
    _secondView = UserView();

  }

  @override
  void afterFirstLayout(BuildContext context) {
    _currentIndex = 0;
    _contentView = _firstView;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _appBar,
      body: new Center(
        child: new Container(
          child: _contentView,
        ),
      ),
      bottomNavigationBar: new CupertinoTabBar(
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text("Home")),
          new BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("My"))
        ],
        onTap: (index) async {

          setState(() {
            _currentIndex = index;
            if (_currentIndex == 0) {
              _contentView = _firstView;
            }else if (_currentIndex == 1) {
              _contentView = _secondView;
            }
          });

        },
      ),
    );
  }
}
