import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:expandable/expandable.dart';

import 'package:lhs_connections/models/Club.dart';



class _CurrentClubState extends State<> {

  final Club currentClub;

  _CurrentClubState({Key key, this.currentClub}) : super(key: key);


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
              makePostCard(currentClub);
            },
            childCount: 10,
          ),
        ),

      ],
    );
  }

  Card makePostCard(Club act) {
    /*return ExpandablePanel(
      header: Text("Lorem ipsum",
        style: TextStyle(color: Colors.white),
      ),
      expanded: Text("wow", softWrap: true, ),
      tapHeaderToExpand: true,
      hasIcon: true,
    );*/
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),

        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.grey[350]))),
            child: Icon(act.icon, color: Colors.grey[350]),
          ),

          title: Text(
            act.name,
            style:
            TextStyle(
                color: Colors.grey[350],
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),

          trailing: Icon(Icons.keyboard_arrow_right,
              color: Colors.grey[350], size: 30.0),
        ),
      ),
    );
  }



}
