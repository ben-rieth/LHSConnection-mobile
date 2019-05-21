import 'package:flutter/material.dart';

import 'package:lhs_connections/widgets/tutor/tutor_console_card.dart';

class CurrentTutorScreen extends StatefulWidget {

  State<CurrentTutorScreen> createState() => _CurrentTutorScreenState();
}

class _CurrentTutorScreenState extends State<CurrentTutorScreen>
  with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 5, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Tutor Console"),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[

            Tab(text: "MON",),
            Tab(text: "TUE",),
            Tab(text: "WED",),
            Tab(text: "THU",),
            Tab(text: "FRI",),

          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: <Widget>[

          TutorConsoleCard(isActive: true, day: "Monday"),
          TutorConsoleCard(isActive: true, day: "Tuesday"),
          TutorConsoleCard(isActive: false, day: "Wedensday"),
          TutorConsoleCard(isActive: false, day: "Thursday"),
          TutorConsoleCard(isActive: true, day: "Friday"),

        ],
      ),
    );
  }

}