import 'package:flutter/material.dart';

import 'package:lhs_connections/Models/Activity.dart';

class Club extends Activity {

  String sponsor;

  Club({String name, String description, IconData icon, List<String> tags,
    this.sponsor})
      : super(name: name, description: description, icon: icon, tags: tags);
}