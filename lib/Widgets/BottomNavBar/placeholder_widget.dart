import 'package:flutter/material.dart';

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {

    FocusScope.of(context).requestFocus(new FocusNode());

    return Container(
      color: color,
    );
  }
}