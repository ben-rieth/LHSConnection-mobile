import 'package:flutter/material.dart';

import 'package:lhs_connections/widgets/home_widget.dart';
import 'package:lhs_connections/widgets/login_widget.dart';

class AppRoot extends StatefulWidget {
  @override
  State<AppRoot> createState() => new AppRootState();
}

class AppRootState extends State<AppRoot> {
  ThemeData get _themeData => ThemeData(
    primaryColor: Colors.green,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LHS Connection',
      theme: _themeData,
      home: LoginPage(),
      routes: {
        "/home": (_) => new Home(),
        "/login": (_) => new LoginPage(),
      },
    );
  }
}