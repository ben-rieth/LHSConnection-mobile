import 'package:flutter/material.dart';

import 'package:lhs_connections/app_root.dart';
import 'package:lhs_connections/app_state_container.dart';


void main() {
  runApp(new AppStateContainer(
    child: new AppRoot(),
  ));

}