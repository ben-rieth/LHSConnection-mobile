import 'package:flutter/material.dart';

import 'package:lhs_connections/widgets/home_widget.dart';
import 'package:lhs_connections/widgets/login_widget.dart';
//import 'package:lhs_connections/widgets/bottom_nav_bar/settings/interests_select_widget.dart';
//import 'package:lhs_connections/widgets/bottom_nav_bar/placeholder_widget.dart';
import 'package:lhs_connections/widgets/bottom_nav_bar/settings/interests_select_widget.dart';

///The AppRoot class holds the main MaterialApp which starts the rest of the ui
///   tree. It defines the theme for the app and sets the start page as the Login
///   page.
class AppRoot extends StatefulWidget {
  @override
  State<AppRoot> createState() => new AppRootState();
}

class AppRootState extends State<AppRoot> {
  ///Sets the color scheme for the app
  /// -> https://docs.flutter.io/flutter/material/ThemeData-class.html
  ThemeData get _themeData => ThemeData(
    primaryColor: Colors.green,
  );

  ///The MaterialApp is the top of the ui tree and navigator and sets material
  ///   design principles for the rest of the app.
  ///
  ///    title: (String) -> identifies the app
  ///    theme: (ThemeData) -> default visual properties for the app
  ///    home: (Widget) -> the default route of the app
  ///    -> https://docs.flutter.io/flutter/material/MaterialApp-class.html
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