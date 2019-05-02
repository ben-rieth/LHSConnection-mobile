import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:lhs_connections/models/Interest.dart';
import 'package:lhs_connections/app_state_container.dart';
import 'package:lhs_connections/models/dummy_data/dummy_interests.dart';

class Interests extends StatefulWidget {
  State<Interests> createState() => _InterestsState();
}

class _InterestsState extends State<Interests> {

  List<Interest> _selectedInterests = [];

  final dummyFineArtsList = [

    Interest(name: "Band", icon: MdiIcons.music, selectedByCurrentUser: true),

    Interest(name: "Theater", icon: MdiIcons.dramaMasks, selectedByCurrentUser: false),

    Interest(name: "Singing", icon: MdiIcons.music, selectedByCurrentUser: true),

    Interest(name: "Acting", icon: MdiIcons.dramaMasks, selectedByCurrentUser: false),

    Interest(name: "Extra", icon: MdiIcons.crosshairs, selectedByCurrentUser: false)

  ];

  @override
  Widget build(BuildContext context) {
    //var container = AppStateContainer.of(context);

    return Scaffold(

      appBar: AppBar(
        title: Text("Select Interests"),
      ),

      body: CustomScrollView(
        slivers: <Widget>[

          makeSliverHeader("Fine Arts"),

          makeInterestGrid(dummyFineArtsList),

          makeSliverHeader("Athletic")

        ],
      ),
    );
  }

  SliverGrid makeInterestGrid(List<Interest> interests) {
    
    List<Widget> gridChildren = [];
    
    interests.forEach((interest) {
        print(interest.toString());
        gridChildren.add(makeInterestButton(interest));
    });

    /*if(gridChildren.length%4 != 0) {
      for(var i = gridChildren.length%4 ; i > 0 ; i--) {
        print(i);
        gridChildren.add(Card());
      }
    }*/

    return SliverGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 2.0,
      children: gridChildren,
    );
  }
  
  Widget makeSliverHeader(String headerText) {
    return SliverPersistentHeader(
      delegate: _SliverHeaderDelegate(
        minHeight: 60.0,
        maxHeight: 60.0,
        child: Container(
          margin: EdgeInsets.only(bottom: 5.0),
          color: Colors.green[800],
          child: Center(
            child: Text(
              headerText.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget makeInterestButton(Interest interest) {

    return GestureDetector(
      onTap: () {
        setState(() {
          interest.selectedByCurrentUser = !interest.selectedByCurrentUser;
        });
      },
      child: Card(
        elevation: 5.0,
        child: Column(
          children: [

            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Icon(
                interest.icon,
                size: 40.0,
                color: interest.selectedByCurrentUser ? Colors.green : Colors.grey,
              ),
            ),

            Text(
              interest.name.toUpperCase(),
              style: TextStyle(
                color: interest.selectedByCurrentUser ? Colors.green : Colors.grey,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  _SliverHeaderDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
