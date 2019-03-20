import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:lhs_connections/models/Club.dart';

class PotentialClubPage extends StatelessWidget {

  final Club potentialClub;

  PotentialClubPage({Key key, this.potentialClub}) : super(key : key);

  @override
  Widget build(BuildContext context) {

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 55.0),
        Icon(
          potentialClub.icon,
          color: Colors.white,
          size: 40.0,
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.yellowAccent),
        ),
        SizedBox(height: 10.0),
        Text(
          potentialClub.name,
          style: TextStyle(color: Colors.white, fontSize: 40.0),
        ),
        SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 6, child: makeTagSubtitle(potentialClub)),
          ],
        ),

      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0),
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/desks.png"),
                fit: BoxFit.cover,)),
        ),

        Opacity(
          opacity: .7,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            padding: EdgeInsets.all(40.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.green),
          ),
        ),

        Container(
          height: MediaQuery.of(context).size.height * 0.5,
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

    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Text (
              potentialClub.description,
              style: TextStyle(fontSize: 18.0),
            ),

            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: IconButton(
                    color: Colors.green,
                    icon: Icon(Icons.email),
                    onPressed: () {},
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: IconButton(
                    color: Colors.green,
                    icon: Icon(FontAwesomeIcons.instagram),
                    onPressed: () {},
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }

  Text makeTagSubtitle(Club potentialClass) {
    String tagSubtitle = "";

    potentialClass.tags.forEach((tag) {
      tagSubtitle += "$tag, ";
    });

    tagSubtitle = tagSubtitle.trim();
    tagSubtitle = tagSubtitle.substring(0, tagSubtitle.length - 1);

    return Text(tagSubtitle, style: TextStyle(color: Colors.white));
  }

}