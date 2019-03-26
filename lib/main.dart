import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:lhs_connections/widgets/home_widget.dart';
//import 'package:lhs_connections/widgets/login_widget.dart';
import 'package:lhs_connections/redux_utils/app_state.dart';
import 'package:lhs_connections/redux_utils/reducers/app_reducer.dart';

import 'package:lhs_connections/redux_utils/middleware/auth_middleware.dart';

/*void main() {
  StateWidget stateWidget = new StateWidget(
    child: App(),
  );
  runApp(stateWidget);
}*/

void main() => runApp(App());

class App extends StatelessWidget {

  final store = new Store<AppState> (
    appReducer,
    initialState: new AppState(),
    middleware: [middleware].toList(),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'LHS Connection',
        theme: ThemeData(
          primaryColor: Colors.green,
        ),
        home: Home(),
        routes: {
          "/home": (_) => new Home(),
        },
      ),
    );
  }
}