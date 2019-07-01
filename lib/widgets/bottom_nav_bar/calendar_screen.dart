import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Calendar"),
      ),

      body: Column(

        children: <Widget>[
          TableCalendar(
            availableCalendarFormats: {CalendarFormat.week : "Week", CalendarFormat.twoWeeks : "Two Week"},
            initialCalendarFormat: CalendarFormat.twoWeeks,
          ),
        ],



      ),

    );
  }
}