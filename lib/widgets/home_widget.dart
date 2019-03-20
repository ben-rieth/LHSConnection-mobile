import 'package:flutter/material.dart';

import 'package:lhs_connections/Widgets/bottom_nav_bar/placeholder_widget.dart';
import 'package:lhs_connections/Widgets/bottom_nav_bar/account_widget.dart';
import 'package:lhs_connections/Widgets/bottom_nav_bar/search_widget.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final List<Widget> _children = [
    AccountPage(),
    Search(),
    PlaceholderWidget(Colors.green),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: new Scaffold(
        appBar: AppBar(
          title: Text("LHS Connection"),
        ),

        body: TabBarView(
          children: _children,
        ),

        bottomNavigationBar: new TabBar(
          tabs: [
            Tab(
              icon: new Icon(Icons.account_circle),
              text: "Account",
            ),
            Tab(
              icon: new Icon(Icons.search),
              text: "Search",
            ),
            Tab(
              icon: new Icon(Icons.whatshot),
              text: "News",
            ),
          ],
          labelColor: Colors.yellow,
          unselectedLabelColor: Colors.blue,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: Colors.red,
        )
      )
    );
  }
}
