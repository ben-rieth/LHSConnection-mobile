
enum CalendarEventType {
  school,
  sport
}

class CalendarEvent {

  String eventName;
  DateTime startTime;
  DateTime endTime;
  CalendarEventType eventType;

  CalendarEvent({this.eventName, this.startTime, this.endTime,
    this.eventType});

}