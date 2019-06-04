import 'package:flutter/material.dart';

class SwitchIconButton extends StatefulWidget {

  bool activated;
  final IconData icon;
  final String title;
  final Color activatedColor;
  final Color color;


  SwitchIconButton({
    @required this.activated,
    @required this.icon,
    @required this.title,
    @required this.activatedColor,
    @required this.color,
    Key key})
      : super(key: key);

  State<SwitchIconButton> createState() => _SwitchIconButtonState();

}

class _SwitchIconButtonState extends State<SwitchIconButton> {

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        setState(() {
          widget.activated = !widget.activated;
        });
      },

      child: Card(
        elevation: 5.0,
        child: Column(
          children: <Widget>[

            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Icon(
                widget.icon,
                size: 35.0,
                color: widget.activated ? widget.activatedColor : widget.color,
              ),
            ),

            Text(
             widget.title,
             style: TextStyle(
               color: widget.activated ? widget.activatedColor : widget.color,
               fontSize: 14.0,
               fontWeight: FontWeight.bold,
             ),
            ),

          ],
        ),
      ),

    );

  }

}