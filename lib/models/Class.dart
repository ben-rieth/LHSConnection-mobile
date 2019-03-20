import 'package:flutter/material.dart';

import 'package:lhs_connections/models/Activity.dart';

class Class extends Activity {
  double numCredit;

  Class({String name, String description, this.numCredit, IconData icon, List<String> tags}) :
        super(name: name, description: description, icon: icon, tags: tags);

}