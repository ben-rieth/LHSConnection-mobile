import 'package:flutter/material.dart';
import 'package:lhs_connections/widgets/custom_widgets/checkbox_button.dart';

class PlaceholderWidget extends StatelessWidget {

  PlaceholderWidget();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: <Widget>[

        SizedBox(height: 100.0),

        Container(
          height: 80.0,
          width: 80.0,
          color: Colors.white,
          child: CheckboxIconButton(
              startActivated: false,
              icon: Icons.check,
              title: "Click Me!",
            iconSize: 40.0,
          ),
        )


      ],
    ),
  );


  }
}