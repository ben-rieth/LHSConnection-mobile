import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:lhs_connections/widgets/bottom_nav_bar/calendar_widgets/event_marker.dart';

class CalendarScreen extends StatefulWidget {
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen>
  with TickerProviderStateMixin {

  DateTime _selectedDay;
  Map<DateTime, List> _events;
  Map<DateTime, List> _holidays;
  Map<DateTime, List> _visibleEvents;
  Map<DateTime, List> _visibleHolidays;
  List _selectedEvents;
  AnimationController _controller;

  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _selectedDay = DateTime.now();

    _events = {
      _selectedDay.subtract(Duration(days: 30)): ['Event A0', 'Event B0', 'Event C0'],
      _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
      _selectedDay.subtract(Duration(days: 20)): ['Event A2', 'Event B2', 'Event C2', 'Event D2'],
      _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
      _selectedDay.subtract(Duration(days: 10)): ['Event A4', 'Event B4', 'Event C4'],
      _selectedDay.subtract(Duration(days: 4)): ['Event A5', 'Event B5', 'Event C5'],
      _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      _selectedDay.add(Duration(days: 1)): ['Event A8', 'Event B8', 'Event C8', 'Event D8'],
      _selectedDay.add(Duration(days: 3)): Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      _selectedDay.add(Duration(days: 7)): ['Event A10', 'Event B10', 'Event C10'],
      _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
      _selectedDay.add(Duration(days: 17)): ['Event A12', 'Event B12', 'Event C12', 'Event D12'],
      _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
      _selectedDay.add(Duration(days: 26)): ['Event A14', 'Event B14', 'Event C14'],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _visibleEvents = _events;

    _holidays = {};
    _visibleHolidays = _holidays;

    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds:  400)
    );

    _controller.forward();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Calendar"),
      ),

      body: Column(

        children: <Widget>[
          TableCalendar(
            events: _visibleEvents,
            holidays: _visibleHolidays,
            availableCalendarFormats: {CalendarFormat.week : "Week", CalendarFormat.twoWeeks : "Two Week"},
            initialCalendarFormat: CalendarFormat.twoWeeks,
            onDaySelected: _onDaySelected,
            onVisibleDaysChanged: _onVisibleDaysChanged,
            builders: CalendarBuilders(
              markersBuilder: (context, date, events, holidays) {
                final children = <Widget>[];

                int schoolActivities = 0;
                int sportActivities = 0;

                if (events.isNotEmpty) {

                  children.add(
                    Positioned(
                      right: 1,
                      bottom: 1,
                      child: EventMarker(
                        numEvents: schoolActivities,
                        date: date,
                        selectedDay : _selectedDay,
                      ),
                    ),
                  );

                  children.add(
                    Positioned(
                      left: 1,
                      bottom: 1,
                      child: EventMarker(
                        numEvents: sportActivities,
                        date: date,
                        selectedDay : _selectedDay,
                      ),
                    ),
                  );

                  return children;

                }
              }
            ),
          ),

          TabBar(
            controller: _tabController,
            tabs: <Widget> [
              Tab(text: "School"),
              Tab(text: "Sports"),
            ],
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Colors.lightGreen,
          ),

          const SizedBox(height: 8.0),

          Expanded(

            child: ListView(
              shrinkWrap: true,
              children: _selectedEvents
                .map((event) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.8, color: Colors.green),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event.toString()),
                )))
                .toList(),
            ),
          ),

        ],



      ),

    );
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedDay = day;
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    setState(() {
      _visibleEvents = Map.fromEntries(
        _events.entries.where(
              (entry) =>
          entry.key.isAfter(first.subtract(const Duration(days: 1))) &&
              entry.key.isBefore(last.add(const Duration(days: 1))),
        ),
      );
    });
  }


}