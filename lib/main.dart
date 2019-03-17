import 'package:flutter/material.dart';

import 'package:lhs_connections/Widgets/home_widget.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LHS Connection',
      home: Home(),
    );
  }
}