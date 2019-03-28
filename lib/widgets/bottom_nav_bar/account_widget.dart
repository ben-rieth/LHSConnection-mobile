import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:lhs_connections/models/Class.dart';
import 'package:lhs_connections/models/Club.dart';
import 'package:lhs_connections/app_state_container.dart';

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
    Club(name: "Robotics", icon: Icons.android),
    Club(name: "Marching Band", icon: Icons.music_note),
    Club(name: "Set Crew", icon: Icons.people),
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
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
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
                    container.state.userInformation.name,
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
    } else {
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

          /*onTap: () {
            if(act is Class) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PotentialClassPage(potentialClass: act)));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PotentialClubPage(potentialClub: act)));
            }
          },*/
        ),
      ),
    );

  }
}

class BasicUser {

  final DocumentReference reference;

  String uname;
  String email;
  String uid;



  BasicUser.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['uname'] != null),
        assert(map['email'] != null),
        assert(map['uid'] != null),

        uname = map['uname'],
        email = map['email'],
        uid = map['uid'];

  BasicUser.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}