import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:lhs_connections/redux_utils/app_state.dart';
import 'package:lhs_connections/redux_utils/actions/counter_actions.dart';

class IncreaseCountButton extends StatelessWidget {
  IncreaseCountButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, VoidCallback>(
      converter: (Store<AppState> store) {
        return () {
          store.dispatch(new IncrementsCountAction());
        };
      },
      builder: (BuildContext context, VoidCallback increase) {
        return new FloatingActionButton(
          onPressed: increase,
          child: new Icon(Icons.add),
        );
      },
    );
  }
}