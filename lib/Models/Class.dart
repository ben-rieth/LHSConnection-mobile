import 'package:flutter/material.dart';

import 'package:lhs_connections/Models/Activity.dart';

class Class extends Activity {
  double numCredit;

  Class(String name, double numCredit, IconData icon, List<String> tags) {
    this.name = name;
    this.numCredit = numCredit;
    this.icon = icon;
    this.tags = tags;
  }

  Class.description(String name, String description, double numCredit, IconData icon,
      List<String> tags) {
    this.name = name;
    this.description = description;
    this.numCredit = numCredit;
    this.icon = icon;
    this.tags = tags;
  }

}