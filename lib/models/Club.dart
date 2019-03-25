import 'package:flutter/material.dart';

import 'package:lhs_connections/Models/Activity.dart';

class Club extends Activity {

  String sponsor;

  Club(String name, String sponsor, IconData icon, List<String> tags) {
    this.name = name;
    this.sponsor = sponsor;
    this.icon = icon;
    this.tags = tags;
  }

  Club.description(String name, String description, String sponsor, IconData icon,
      List<String> tags) {
    this.name = name;
    this.description = description;
    this.sponsor = sponsor;
    this.icon = icon;
    this.tags = tags;
  }
}