import 'package:flutter/material.dart';

class Settings extends StatefulWidget{
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.grey[350],
      ),

      body: ListView(

        children: <Widget>[

        ],
      ),
    );
  }
}