import 'package:flutter/material.dart';

class CheckboxIconButton extends StatefulWidget {

  const CheckboxIconButton({
    Key key,
    @required this.value,
    @required this.onChanged,
    this.activeColor,
    this.nonActiveColor,
  }): assert(value != null),
      super(key: key);

  final bool value;

  final ValueChanged<bool> onChanged;

  final Color activeColor;

  final Color nonActiveColor;

  /*final bool startActivated;
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
  }): assert(startActivated != null);*/

  @override
  State<CheckboxIconButton> createState() => _CheckboxIconButtonState();
}

class _CheckboxIconButtonState extends State<CheckboxIconButton> {

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    Size size;





    /*bool activated = false;

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
    );*/
  }
}

class _RenderButton extends RenderToggleable {
  _RenderButton({
    bool value,
    Color activeColor,
    Color inactiveColor,
    ValueChanged<bool> onChanged,
    @required TickerProvider vsync
  }): _oldValue = value,
      super(
        value: value,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        onChanged: onChanged,
        vsync: vsync
      );

  bool _oldValue;

  @override
  set value(bool newValue) {
    if(newValue == value)
      return;
    _oldValue = value;
    super.value = newValue;
  }

}