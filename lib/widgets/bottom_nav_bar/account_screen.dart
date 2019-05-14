import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lhs_connections/models/class.dart';
import 'package:lhs_connections/models/club.dart';
import 'package:lhs_connections/models/user.dart';
//import 'package:lhs_connections/widgets/class_clubs_widgets/current_club_widget.dart';
import 'package:lhs_connections/widgets/settings/settings_home_screen.dart';
import 'package:lhs_connections/widgets/settings/edit_account_screen.dart';
import 'package:lhs_connections/blocs/authentication_bloc/bloc.dart';
import 'package:lhs_connections/widgets/tutor/current_tutor.dart';

class AccountPage extends StatefulWidget {

  final User user;

  AccountPage({Key key, @required this.user}) : super(key: key);

  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with SingleTickerProviderStateMixin {

  String gradeLevel;

  TabController _tabController;

  final List<Club> _clubList = [
    Club(name: "Robotics", sponsor: "Mrs. Lorey", icon: Icons.android,),
    //description: robDescrip),
    Club(name: "Marching Band",  sponsor: "Mr. Wyss", icon: Icons.audiotrack,),
    Club(name: "Set Crew", sponsor: "Mr. Blackwood", icon: Icons.weekend,),
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
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

  }

  @override
  void dispose() {

    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SwipeDetector(
      onSwipeLeft: _swipeLeft,
      onSwipeRight: _swipeRight,
      child: Scaffold(

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  "${widget.user.fName} " +
                      "${widget.user.lName}",
                ),

                accountEmail: Text(
                  widget.user.email,
                ),

                currentAccountPicture: CircleAvatar(
                  child: Text("Picture"),
                ),

              ),

              ListTile(
                leading: Icon(Icons.school),
                title: widget.user.isTutor ? Text("Tutoring") : Text("Be a Tutor"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => CurrentTutorScreen()));
                },
              ),

              ListTile(
                leading: Icon(Icons.edit),
                title: Text("Edit Account"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => (EditAccount())));
                },
              ),

              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => (Settings())));
                },
              ),

              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Sign Out"),
                onTap: () {
                  BlocProvider.of<AuthenticationBloc>(context).dispatch(
                    LoggedOut(),
                  );
                },
              ),
            ],


          ),

        ),

        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Account",
            style: TextStyle(color: Colors.white),
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Column(
            children: <Widget>[

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
        physics: BouncingScrollPhysics(),
        itemCount: type.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(type[index]),
          );
        },
      );
    } else if (type is List<Club> || type is List<Class>){
      return ListView.builder(
        physics: BouncingScrollPhysics(),
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
                    right: new BorderSide(width: 1.0, color: Colors.white))),
            child: Icon(act.icon, color: Colors.white),
          ),

          title: Text(
            act.name,
            style:
            TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),

          trailing: Icon(Icons.keyboard_arrow_right,
              color: Colors.white, size: 30.0),

          /*onTap: () {
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
          },*/
        ),
      ),
    );

  }
}