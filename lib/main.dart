import 'package:flutter/material.dart';

import 'package:lhs_connections/app_root.dart';
import 'package:lhs_connections/app_state_container.dart';

/// The main() function is the entrypoint to the app.
/// The runApp() method is run by main() and it creates the Widget tree for the
///   app, starting the tree with an AppStateContainer.
/// The AppStateContainer holds the state of the app and has a child widget of
///   AppRoot, which begins to build the UI of the app.
void main() {
  runApp(new AppStateContainer(
    child: new AppRoot(),
  ));

}