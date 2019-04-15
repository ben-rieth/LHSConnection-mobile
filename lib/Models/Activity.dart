import 'package:flutter/material.dart';

abstract class Activity {
  String name;
  String description;
  IconData icon;
  List<String> tags;

  Activity({this.name, this.description, this.icon, this.tags});
}