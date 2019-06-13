import 'package:flutter/material.dart';

class BasicCard extends StatelessWidget {
  IconData headerIcon;
  IconData trailingIcon;
  final String title;
  final String subtitle;
  final GestureTapCallback onTap;

  BasicCard(
      {@required this.headerIcon,
      @required this.title,
      @required this.subtitle,
      this.trailingIcon,
      this.onTap});

  factory BasicCard.rightArrowCard(IconData headerIcon, String title,
      String subtitle, GestureTapCallback onTap) {
    return BasicCard(
        headerIcon: headerIcon,
        trailingIcon: Icons.keyboard_arrow_right,
        title: title,
        subtitle: subtitle,
        onTap: onTap);
  }
  factory BasicCard.infoCard(
      String title, String subtitle, GestureTapCallback onTap) {
    return BasicCard(
      headerIcon: Icons.speaker_notes,
      trailingIcon: Icons.keyboard_arrow_right,
      title: title,
      subtitle: subtitle,
      onTap: onTap,
    );
  }

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
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(
                        width: 1.0, color: Theme.of(context).primaryColor))),
            child: Icon(headerIcon, color: Theme.of(context).primaryColor),
          ),
          title: Text(
            title,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[600]),
                )
              : Container(),
          trailing: trailingIcon != null
              ? Icon(trailingIcon, color: Colors.grey[600], size: 40.0)
              : Container(),
          onTap: onTap,
        ),
      ),
    );
  }
}
