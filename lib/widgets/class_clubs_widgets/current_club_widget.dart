import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:lhs_connections/models/Club.dart';

class CurrentClubPage extends StatelessWidget {

  final Club currentClub;

  CurrentClubPage({Key key, this.currentClub}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20.0),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child:
              Icon(
                currentClub.icon,
                color: Colors.white,
                size: 40.0
              )
            ),

            Expanded(flex: 5, child: Text(
              currentClub.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
              ),
            )),
          ],
        ),

      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0),
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/desks.png"),
                fit: BoxFit.cover,)),
        ),

        Opacity(
          opacity: .7,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.25,
            padding: EdgeInsets.all(40.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.green),
          ),
        ),

        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: topContentText,
          ),
        ),

        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),

      ],
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent],
      ),
    );
  }

}