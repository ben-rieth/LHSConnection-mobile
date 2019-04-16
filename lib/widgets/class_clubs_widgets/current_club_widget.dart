import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:expandable/expandable.dart';

import 'package:lhs_connections/app_state_container.dart';
import 'package:lhs_connections/models/Club.dart';
import 'package:lhs_connections/models/Post.dart';
import 'package:lhs_connections/widgets/class_clubs_widgets/chat_widget.dart';

class CurrentClubPage extends StatefulWidget{

  final Club currentClub;

  CurrentClubPage(this.currentClub);

  _CurrentClubState createState() => new _CurrentClubState(currentClub);
}

class _CurrentClubState extends State<CurrentClubPage>
    with SingleTickerProviderStateMixin {

  static const loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

  bool onPostTab = true;
  bool onChatTab = false;
  bool onMembersTab = false;

  final Club currentClub;
  TabController _tabController;

  _CurrentClubState(this.currentClub);

  @override
  void initState() {

    _tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final top = Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0),
          decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/desks.png"),
                fit: BoxFit.cover,)),
        ),

        Opacity(
          opacity: .7,
          child: Container(
            padding: EdgeInsets.all(40.0),
            decoration: BoxDecoration(color: Colors.green),
          ),
        ),

      ],
    );

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: top,

        title: Text(
          currentClub.name,
          style: TextStyle(
              fontSize: 28.0
          )),
        centerTitle: true,

        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(text: "POSTS"),
            Tab(text: "CLUB CHAT"),
            Tab(text: "MEMBERS"),
          ],

        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: <Widget>[

          ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return makePostCards();
            },
            itemCount: 10,
          ),

          ChatScreen(),

          ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return makeClubMembers();
            },
            itemCount: 10,
          ),

        ],
      ),

    );

    /*return SwipeDetector(
      onSwipeLeft: _swipeLeft,
      onSwipeRight: _swipeRight,
      child: CustomScrollView(
        slivers: <Widget>[

          SliverAppBar(
            floating: true,
            expandedHeight: 100.0,
            backgroundColor: Colors.grey[350],
            pinned: true,
            primary: true,
            snap: true,
            flexibleSpace: top,
            title: Text(
              currentClub.name,
              style: TextStyle(
                fontSize: 28.0
              )),
            centerTitle: true,
            bottom: TabBar(
              controller: _tabController,
              onTap: _changeTab,
              tabs: <Widget>[
                Tab(text: "POSTS"),
                Tab(text: "CLUB CHAT"),
                Tab(text: "MEMBERS"),
              ],
            ),
          ),

          onPostTab ? SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return makePostCards();
              },
              childCount: 10,
            ),
          ) : SliverPadding(padding: EdgeInsets.all(0.0)),

          onChatTab ? SliverList(
            delegate: SliverChildListDelegate([
              ChatScreen(),
            ]),
          ) : SliverPadding(padding: EdgeInsets.all(0.0)),

          onMembersTab ? SliverList(
            delegate: SliverChildListDelegate([
              ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return makeClubMembers();
                },
                itemCount: 10,
              ),
            ]),
          ) : SliverPadding(padding: EdgeInsets.all(0.0)),

        ],
      ),
    );*/
  }

  ListTile makeClubMembers() {
    return ListTile(
      title: Text("Member List Wow", style: TextStyle(color: Colors.black)),

    );
  }

  Card makePostCards() {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ExpandableNotifier(
        child: Column(
          children: <Widget>[

            SizedBox(
              height: 150.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.rectangle,
                ),
              ),
            ),

            ExpandablePanel(
              tapHeaderToExpand: true,

              header: Padding(
                padding: EdgeInsets.only(top: 10.0, left: 10.0),
                child: Text(
                  "Lorem ipsum",
                  //style: TextStyle(),
                )
              ),

              collapsed: Text(loremIpsum, softWrap: false, overflow: TextOverflow.ellipsis),
              expanded: Text(loremIpsum, softWrap: true, overflow: TextOverflow.fade),

              builder: (_, collapsed, expanded) {
                return Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                  child: Expandable(
                    collapsed: collapsed,
                    expanded: expanded,
                  ),
                );
              }

            ),

          ],
        ),
      ),
    );
  }

}
