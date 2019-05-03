import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lhs_connections/models/Class.dart';
import 'package:lhs_connections/models/Club.dart';
import 'package:lhs_connections/models/tags.dart';
import 'package:lhs_connections/app_state_container.dart';
import 'package:lhs_connections/widgets/class_clubs_widgets/current_club_widget.dart';
import 'package:lhs_connections/widgets/bottom_nav_bar/settings/settings_widget.dart';
import 'package:lhs_connections/widgets/bottom_nav_bar/settings/edit_account_widget.dart';

class AccountPage extends StatefulWidget {

  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with SingleTickerProviderStateMixin {

  CollectionReference dbUsers = Firestore.instance.collection('users');

  String name;
  String gradeLevel;

  TabController _tabController;

  final List<Club> _clubList = [
    Club(name: "Robotics", sponsor: "Mrs. Lorey", icon: Icons.android,
        tags: [Tags.tech, Tags.engineering, Tags.robot],),
        //description: robDescrip),
    Club(name: "Marching Band",  sponsor: "Mr. Wyss", icon: Icons.audiotrack,
        tags: [Tags.music]),
    Club(name: "Set Crew", sponsor: "Mr. Blackwood", icon: Icons.weekend,
        tags: [Tags.engineering, Tags.construction, Tags.perf_arts]),
  ];
  final List<Class> _classList = [
    Class(name: "Symphonic Band", icon: Icons.music_note),
    Class(name: "AP Psychology", icon: Icons.people),
    Class(name: "AP Calculus AB", icon: Icons.add),
    Class(name: "AP English Literature", icon: Icons.book),
    Class(name: "AP Physics 2", icon: Icons.grade),
    Class(name: "IB Computer Science 2", icon: Icons.computer),
    Class(name: "A+ Certification", icon: Icons.computer),
  ];

  final List<String> _interestList = ["Guitar", "Music", "Reading", "Computers"];

  @override
  void initState() {

    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {

    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var container = AppStateContainer.of(context);

    return SwipeDetector(
      onSwipeLeft: _swipeLeft,
      onSwipeRight: _swipeRight,
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.grey[350],
          title: Text(
            "Account",
            style: TextStyle(color: Colors.green),
          ),
          actions: <Widget>[

            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.green,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => (EditAccount())));
              },
            ),

            IconButton(
              icon: Icon(Icons.settings),
              color: Colors.green,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => (Settings())));
              },
            ),
          ],
        ),

        body: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Column(
            children: <Widget>[

              SizedBox(height: 15.0),

              Center(
                child: CircleAvatar(
                  child: Text("Picture"),
                  radius: 50.0,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Center(
                  child: Text(
                    "${container.state.userInformation.fName} "
                        + "${container.state.userInformation.lName}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Center(
                  child: Text(
                    container.state.userInformation.gradeLevel,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),

              TabBar(
                tabs: [
                  Tab(text: "CLASSES"),
                  Tab(text: "CLUBS"),
                  Tab(text: "INTERESTS"),
                ],
                labelColor: Colors.green,
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: EdgeInsets.all(5.0),
                indicatorColor: Colors.lightGreen,
                controller: _tabController,
              ),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget> [

                    _buildAccountViews(_classList),
                    _buildAccountViews(_clubList),
                    _buildAccountViews(_interestList),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );


  }

  void _swipeLeft() {
    setState(() {
      if(_tabController.index+1 <= 2) {
        _tabController.animateTo(_tabController.index+1);
      }
    });
  }

  void _swipeRight() {
    setState(() {
      if(_tabController.index-1 >= 0) {
        _tabController.animateTo(_tabController.index-1);
      }
    });
  }

  Widget _buildAccountViews(List type) {
    if (type is List<String>) {
      return ListView.builder(
        itemCount: type.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(type[index]),
          );
        },
      );
    } else if (type is List<Club> || type is List<Class>){
      return ListView.builder(
        itemCount: type.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(type[index]);
        },
      );
    }
  }

  Widget makeCard(dynamic act) {

    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),

        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.grey[350]))),
            child: Icon(act.icon, color: Colors.grey[350]),
          ),

          title: Text(
            act.name,
            style:
            TextStyle(
                color: Colors.grey[350],
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),

          trailing: Icon(Icons.keyboard_arrow_right,
              color: Colors.grey[350], size: 30.0),

          onTap: () {
            if(act is Class) {
              /*Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PotentialClassPage(potentialClass: act)));*/
            } else if (act is Club){

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CurrentClubPage(act)
                  ));
            } else {

            }
          },
        ),
      ),
    );

  }
}