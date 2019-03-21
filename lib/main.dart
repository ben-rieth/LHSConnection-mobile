import 'package:flutter/material.dart';

//import 'package:lhs_connections/widgets/home_widget.dart';
import 'package:lhs_connections/widgets/login_widget.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LHS Connection',
      home: LoginPage(),
    );
  }
}