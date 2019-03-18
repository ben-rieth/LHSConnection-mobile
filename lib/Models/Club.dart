import 'package:flutter/material.dart';

class Club {

  String name;
  String description;
  String sponsor;
  IconData icon;
  List<String> tags;

  Club({this.name, this.description, this.icon, this.sponsor, this.tags});
}