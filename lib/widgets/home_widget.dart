import 'package:flutter/material.dart';

//import 'package:lhs_connections/Widgets/bottom_nav_bar/placeholder_widget.dart';
import 'package:lhs_connections/widgets/bottom_nav_bar/account_widget.dart';
import 'package:lhs_connections/widgets/bottom_nav_bar/search_widget.dart';
import 'package:lhs_connections/widgets/bottom_nav_bar/calander.dart';

class Home extends StatefulWidget {
  final String currentUserId;

  Home({Key key, @required this.currentUserId});

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

  _HomeState({Key key, this.currentUserId});

  final String currentUserId;
  final List<Widget> _children = [
    AccountPage(),
    Search(),
    NewsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: new Scaffold(
        /*appBar: AppBar(
          title: Text("LHS Connection"),
        ),*/

        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
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
              text: "Calander",
            ),
          ],
          labelColor: Colors.green,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: Colors.lightGreen,
        )
      )
    );
  }
}
