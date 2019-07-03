import 'package:flutter/material.dart';
import 'package:date_utils/date_utils.dart';

class EventMarker extends StatelessWidget {

  final int numEvents;
  final DateTime date;
  final DateTime selectedDay;

  EventMarker({this.numEvents, this.date, this.selectedDay});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Utils.isSameDay(date, selectedDay)
            ? Colors.brown[500]
            : Utils.isSameDay(date, DateTime.now())
              ? Colors.brown[300] : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          numEvents.toString(),
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),


        ),
      ),
    );
  }
}