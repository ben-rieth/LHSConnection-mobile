import 'package:flutter/material.dart';

class TutorConsoleCard extends StatefulWidget {
  bool isActive;
  final String day;

  TutorConsoleCard({Key key, @required this.isActive, @required this.day})
      : super(key: key);

  State<TutorConsoleCard> createState() => _TutorConsoleCardState();
}

class _TutorConsoleCardState extends State<TutorConsoleCard> {
  @override
  Widget build(BuildContext context) {

    return CustomScrollView(
      slivers: <Widget>[

        SliverList(
          delegate: SliverChildListDelegate(
            [

              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  widget.isActive ? "Stop Tutoring?" : "Start Tutoring?",
                ),
                onPressed: () {
                  if (widget.isActive) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Stop Tutoring on ${widget.day}?"),
                            content: Text(
                                "Accpeting will relive you of all tutoring on"
                                    " ${widget.day}s."),
                            actions: <Widget>[
                              FlatButton(
                                  child: Text("CANCEL"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                              FlatButton(
                                  child: Text("ACCEPT"),
                                  onPressed: () {
                                    widget.isActive = !widget.isActive;
                                    Navigator.pop(context);
                                  }),
                            ],
                          );
                        });
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Start Tutoring on ${widget.day}"),
                          content: Text("Accepting will allow you to be selected"
                              " to tutor on ${widget.day} and require you to fulfill"
                              " all tutoring obligations on that day."),
                          actions: <Widget>[
                            FlatButton(
                                child: Text("CANCEL"),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            FlatButton(
                                child: Text("ACCEPT"),
                                onPressed: () {
                                  widget.isActive = !widget.isActive;
                                  Navigator.pop(context);
                                }),
                          ],
                        );
                      },
                    );
                  }
                },
              ),


            ]),
        ),



        SliverGrid.count(
          crossAxisCount: 3,
          crossAxisSpacing: 20.0,
          children: <Widget>[

            Align(
              alignment: Alignment.center,
              child: Text(
                "First 20",
                textAlign: TextAlign.center,
              ),
            ),
            TutorTextbox(text: "Benjamin Riethmeier"),
            TutorTextbox(text: "Math"),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Middle 20",
                textAlign: TextAlign.center,
              ),
            ),
            TutorTextbox(text: "Jade Wiley"),
            TutorTextbox(text: "Math"),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Last 20",
                textAlign: TextAlign.center,
              ),
            ),
            TutorTextbox(text: "Pete Korenak"),
            TutorTextbox(text: "English"),

          ],
        ),

      ],
    );

    /*return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Card(
        elevation: 4.0,
        child: ListTile(
          leading: Container(
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(widget.day.substring(0, 3).toUpperCase()),
                Checkbox(
                  value: widget.isActive,
                  onChanged: (bool) {
                    if (widget.isActive) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Stop Tutoring on ${widget.day}?"),
                            content: Text(
                                "Accpeting will relive you of all tutoring on"
                                " ${widget.day}s."),
                            actions: <Widget>[
                              FlatButton(
                                  child: Text("CANCEL"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                              FlatButton(
                                  child: Text("ACCEPT"),
                                  onPressed: () {
                                    widget.isActive = !widget.isActive;
                                    Navigator.pop(context);
                                  }),
                            ],
                          );
                        });
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Start Tutoring on ${widget.day}"),
                            content: Text("Accepting will allow you to be selected"
                                " to tutor on ${widget.day} and require you to fulfill"
                                " all tutoring obligations on that day."),
                            actions: <Widget>[
                              FlatButton(
                                  child: Text("CANCEL"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                              FlatButton(
                                  child: Text("ACCEPT"),
                                  onPressed: () {
                                    widget.isActive = !widget.isActive;
                                    Navigator.pop(context);
                                  }),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          title: widget.isActive
              ? GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "First 20",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TutorTextbox(text: "Jade"),
                    TutorTextbox(text: "Math"),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Middle 20",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TutorTextbox(text: "Jade Wiley"),
                    TutorTextbox(text: "Math"),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Last 20",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TutorTextbox(text: "Pete Korenak"),
                    TutorTextbox(text: "English"),
                  ],
                )
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Text("Not Tutoring ${widget.day}"),
                ),
        ),
      ),
    );*/
  }
}

class TutorTextbox extends StatelessWidget {
  String text;

  TutorTextbox({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          maxLines: null,
          controller: TextEditingController(text: text),
          enabled: false,
        ),
      ),
    );
  }
}
