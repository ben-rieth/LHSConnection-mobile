import 'package:flutter/material.dart';

class RightArrowCard extends StatelessWidget {

  IconData headerIcon;
  final String title;
  final String subtitle;
  final GestureTapCallback onTap;

  RightArrowCard({@required this.headerIcon, @required this.title,
    @required this.subtitle, this.onTap});

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          //color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),

        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Theme.of(context).primaryColor))),
            child: Icon(headerIcon, color: Theme.of(context).primaryColor),
          ),

          title: Text(
            title,
            style:
            TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
          ),

          subtitle: Text(
            subtitle,
            style: TextStyle(color: Colors.grey[600]),
          ),

          trailing: Icon(Icons.keyboard_arrow_right,
              color: Colors.grey[600], size: 40.0),

          onTap: onTap,
        ),
      ),
    );
  }

}
