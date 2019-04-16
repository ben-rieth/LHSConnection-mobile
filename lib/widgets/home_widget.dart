import 'package:flutter/material.dart';

//import 'package:lhs_connections/Widgets/bottom_nav_bar/placeholder_widget.dart';
import 'package:lhs_connections/widgets/bottom_nav_bar/account_widget.dart';
import 'package:lhs_connections/widgets/bottom_nav_bar/search_widget.dart';
import 'package:lhs_connections/widgets/bottom_nav_bar/calander.dart';
import 'package:lhs_connections/widgets/class_clubs_widgets/chat_widget.dart';
import 'package:lhs_connections/utils/app_state.dart';
import 'package:lhs_connections/app_state_container.dart';

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
    NewsPage(),
  ];

  AppState appState;

  Widget get _pageToDisplay {
    if(appState.isLoading) {
      return _loadingView;
    } else {
      return _homeView;
    }
  }

  Widget get _loadingView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget get _homeView {
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



  @override
  Widget build(BuildContext context) {
    var container = AppStateContainer.of(context);

    appState = container.state;

    Widget body = _pageToDisplay;

    return body;
  }
}
