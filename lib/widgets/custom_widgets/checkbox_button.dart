import 'package:flutter/material.dart';

class CheckboxIconButton extends StatefulWidget {

  final bool startActivated;
  final IconData icon;
  final double iconSize;
  final String title;
  final Color activatedColor;
  final Color deactivatedColor;

  CheckboxIconButton({
    @required this.startActivated,
    @required this.icon,
    @required this.title,
    this.iconSize = 20,
    this.activatedColor = Colors.blue,
    this.deactivatedColor = Colors.grey
  }): assert(startActivated != null);

  @override
  State<CheckboxIconButton> createState() => _CheckboxIconButtonState();
}

class _CheckboxIconButtonState extends State<CheckboxIconButton> {

  @override
  Widget build(BuildContext context) {
    bool activated = false;

    return GestureDetector(

      onTap: () {
        setState(() {
          activated = !activated;
        });

      },

      child:Card(
        color: Colors.black,
        child: Column(
          children: <Widget>[

            Icon(
              widget.icon,
              size: widget.iconSize,
              color: activated ? widget.activatedColor : widget.deactivatedColor,
            ),

            Text(
              widget.title,
              style: TextStyle(
                color: Colors.white,
              ),
            ),

          ],
        ),
      ),
    );
  }
}