import 'package:flutter/material.dart';

import 'package:lhs_connections/models/Activity.dart';

class Club extends Activity {

  String sponsor;

  Club({String name, String description, this.sponsor, IconData icon, List<String> tags})
      : super(name: name, description: description, icon: icon, tags: tags);

}