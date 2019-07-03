import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:lhs_connections/models/user.dart';
import 'package:lhs_connections/Widgets/bottom_nav_bar/placeholder_screen.dart';
import 'package:lhs_connections/Widgets/bottom_nav_bar/feed_screen.dart';
import 'package:lhs_connections/widgets/bottom_nav_bar/account_screen.dart';
import 'package:lhs_connections/widgets/bottom_nav_bar/search_widgets/search_screen.dart';
import 'package:lhs_connections/widgets/bottom_nav_bar/calendar_widgets/calendar_screen.dart';

class Home extends StatefulWidget {
  final User user;

  Home({Key key, @required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: new Scaffold(
          /*appBar: AppBar(
          title: Text("LHS Connection"),
        ),*/

            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                AccountPage(user: widget.user),
                SearchScreen(),
                FeedScreen(user: widget.user),
                CalendarScreen(),
              ],
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
                  icon: Icon(FontAwesomeIcons.utensils),
                  text: "Feed",
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