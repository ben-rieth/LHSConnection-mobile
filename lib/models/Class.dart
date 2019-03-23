import 'package:flutter/material.dart';

import 'package:lhs_connections/Models/Activity.dart';

class Class extends Activity {
  double numCredit;
  List<int> gradeLevels;
  List<String> requiredCourses;

  Class({String name, String description, IconData icon, List<String> tags,
    this.numCredit, this.gradeLevels, this.requiredCourses})
      : super(name: name, description: description, icon: icon, tags: tags);

}