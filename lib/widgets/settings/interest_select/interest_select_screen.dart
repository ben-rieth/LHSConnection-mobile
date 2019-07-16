import 'package:flutter/material.dart';

import 'package:Gamut/widgets/settings/interest_select/interest_group_header.dart';
import 'package:Gamut/widgets/settings/interest_select/interest_grid.dart';
import 'package:Gamut/models/interest_lists.dart';

class InterestSelectScreen extends StatefulWidget {
  State<InterestSelectScreen> createState() => _InterestSelectScreenState();
}

class _InterestSelectScreenState extends State<InterestSelectScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Interests"),
      ),

      body: CustomScrollView(
        slivers: <Widget>[

          InterestGroupHeader(headerText: "Athletics"),

          InterestGrid(interestList: athleticInterests),

        ],
      ),
    );
  }

}