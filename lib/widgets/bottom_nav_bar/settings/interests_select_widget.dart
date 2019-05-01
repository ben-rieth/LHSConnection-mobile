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

  final dummyFineArtsList = [

    Interest(name: "Band", icon: MdiIcons.music),

    Interest(name: "Theater", icon: MdiIcons.dramaMasks),

    Interest(name: "Singing", icon: MdiIcons.music),

    Interest(name: "Acting", icon: MdiIcons.dramaMasks),

    Interest(name: "Extra", icon: MdiIcons.crosshairs)

  ];

  @override
  Widget build(BuildContext context) {
    //var container = AppStateContainer.of(context);

    return CustomScrollView(
      slivers: <Widget>[

        SliverAppBar(
          title: Text("Interests"),
        ),

        makeSliverHeader("Fine Arts"),

        makeInterestGrid(dummyFineArtsList),

      ],
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
      children: gridChildren,
    );
  }
  
  Widget makeSliverHeader(String headerText) {
    return SliverPersistentHeader(
      delegate: _SliverHeaderDelegate(
        minHeight: 60.0,
        maxHeight: 60.0,
        child: Container(
          color: Colors.green,
          child: Center(
            child: Text(headerText, style: TextStyle(color: Colors.white),),
          ),
        ),
      ),
    );
  }

  Card makeInterestButton(Interest interest) {
    return Card(
      child: IconButton(
        icon: Icon(interest.icon),
        tooltip: interest.name,
        highlightColor: Colors.green,
        color: Colors.grey,
        onPressed: () {}),
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