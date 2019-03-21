import 'package:flutter/material.dart';

import 'package:lhs_connections/Models/Activity.dart';

class Class extends Activity {
  double numCredit;

  Class({String name, String description, IconData icon, List<String> tags, this.numCredit})
      : super(name: name, description: description, icon: icon, tags: tags);

}