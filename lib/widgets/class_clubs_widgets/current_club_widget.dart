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

  final Club currentClub;
  final _formTitleKey = GlobalKey<FormState>();
  final _formContentKey = GlobalKey<FormState>();

  TabController _tabController;
  TextEditingController _titleController;
  TextEditingController _contentController;

  _CurrentClubState(this.currentClub);

  @override
  void initState() {

    _tabController = TabController(length: 3, vsync: this);

    _titleController = TextEditingController();
    _contentController = TextEditingController();

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

          Stack(
            children: <Widget>[

              ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return makePostCards();
                },
                itemCount: 10,
              ),

              Positioned(
                top: MediaQuery.of(context).size.height * .7,
                left: MediaQuery.of(context).size.width * .78,
                child: Container(
                  height: 70.0,
                  width: 70.0,
                  child: FloatingActionButton(
                    backgroundColor: Colors.green,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return makePostDialog();
                        }
                      );
                    },
                    child: Icon(
                      Icons.add,
                      size: 30.0),
                  ),
                ),
              ),

            ],
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
  }

  ListTile makeClubMembers() {
    return ListTile(
      title: Text("Member List Wow", style: TextStyle(color: Colors.black)),

    );
  }

  AlertDialog makePostDialog() {

    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
      titlePadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),

      title: TextFormField(
        controller: _titleController,
        key: _formTitleKey,
        maxLines: 1,
        style: TextStyle(
          fontSize: 18.0,
        ),
        decoration: InputDecoration(
          hintText: "Title",
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          TextFormField(
            controller: _contentController,
            key: _formContentKey,
            maxLines: 10,
            decoration: InputDecoration(
              hintText: " Content",
              hintStyle: TextStyle(
                fontSize: 14.0,
              ),
              contentPadding: EdgeInsets.all(10.0),
              border: OutlineInputBorder(),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.grey[500],
                ),
                onPressed: () {},
              ),

              IconButton(
                icon: Icon(
                  Icons.link,
                  color: Colors.grey[500],
                ),
                onPressed: () {},
              ),

            ],
          ),

        ],
      ),


      actions: <Widget>[

        FlatButton(
          child: Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),

      ],
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ),

              collapsed: Text(loremIpsum, softWrap: false, overflow: TextOverflow.ellipsis),
              expanded: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Text(loremIpsum, softWrap: true, overflow: TextOverflow.fade),

                ],
              ),

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
