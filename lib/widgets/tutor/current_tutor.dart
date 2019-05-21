import 'package:flutter/material.dart';

import 'package:lhs_connections/widgets/tutor/tutor_console_card.dart';

class CurrentTutorScreen extends StatefulWidget {

  State<CurrentTutorScreen> createState() => _CurrentTutorScreenState();
}

class _CurrentTutorScreenState extends State<CurrentTutorScreen>
  with SingleTickerProviderStateMixin{

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Tutor Console"),
        bottom: TabBar(
          controller: TabController(length: 5, vsync: this),
          tabs: <Widget>[

            Tab(text: "MON",),
            Tab(text: "TUE",),
            Tab(text: "WED",),
            Tab(text: "THU",),
            Tab(text: "FRI",),

          ],
        ),
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        children: <Widget>[

          TutorConsoleCard(isActive: true, day: "Monday"),

          TutorConsoleCard(isActive: false, day: "Tuesday"),

          TutorConsoleCard(isActive: false, day: "Wedensday"),

          TutorConsoleCard(isActive: true, day: "Thursday"),

          TutorConsoleCard(isActive: true, day: "Friday"),

        ],
      ),

    );
  }

}