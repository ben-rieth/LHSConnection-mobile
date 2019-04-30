import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:lhs_connections/models/Interest.dart';

class Interests extends StatefulWidget {
  State<Interests> createState() => _InterestsState();
}

class _InterestsState extends State<Interests> {

  @override
  Widget build(BuildContext context) {

    return CustomScrollView(
      slivers: <Widget>[

      ],
    );

  }

  IconButton makeInterestButton(Interest interest) {

    return IconButton(
      icon: Icon(interest.icon),
      highlightColor: Colors.green,
      color: Colors.grey,
      onPressed: () {

      }
    );
  }

}