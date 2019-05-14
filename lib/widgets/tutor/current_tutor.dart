import 'package:flutter/material.dart';

import 'package:lhs_connections/widgets/tutor/tutor_console_card.dart';

class CurrentTutorScreen extends StatefulWidget {
  State<CurrentTutorScreen> createState() => _CurrentTutorScreenState();
}

class _CurrentTutorScreenState extends State<CurrentTutorScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Tutor Console"),
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