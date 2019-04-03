import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:expandable/expandable.dart';

import 'package:lhs_connections/models/Club.dart';

class CurrentClubPage extends StatelessWidget {

  final Club currentClub;

  CurrentClubPage({Key key, this.currentClub}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final top = Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0),
          decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/desks.png"),
                fit: BoxFit.cover,)),
        ),

        Opacity(
          opacity: .7,
          child: Container(
            padding: EdgeInsets.all(40.0),
            decoration: BoxDecoration(color: Colors.green),
          ),
        ),

        Container(
          //padding: EdgeInsets.all(50.0),
          child: Center(
            child: Text(
              currentClub.name,
              style: TextStyle(
                fontSize: 40.0,
                color: Colors.white,
              ),
            ),
          ),
        ),

      ],
    );

    final chatButton = Container(
      child: RaisedButton(
        onPressed: () {},
        color: Colors.green,
      ),
    );

    return CustomScrollView(
      slivers: <Widget>[

        SliverAppBar(
          floating: true,
          expandedHeight: 100.0,
          backgroundColor: Colors.grey[350],
          pinned: true,
          primary: true,
          snap: true,
          flexibleSpace: top,
        ),

        SliverList(
          delegate: SliverChildListDelegate(
            [
              chatButton,
              Divider(),
            ],
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              makePostCard();
            },
            childCount: 10,
          ),
        ),

      ],
    );
  }

  ExpandablePanel makePostCard() {
    return ExpandablePanel(
      header: Text("Lorem ipsum",
        //style: Theme.of(context).textTheme.body2,
      ),
      expanded: Text(currentClub.description, softWrap: true, ),
      tapHeaderToExpand: true,
      hasIcon: true,
    );
  }

}
