import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:lhs_connections/redux_utils/containers/auth_button/google_auth_button.dart';
import 'package:lhs_connections/redux_utils/actions/auth_actions.dart';
import 'package:lhs_connections/redux_utils/app_state.dart';


class GoogleAuthButtonContainer extends StatelessWidget {
  GoogleAuthButtonContainer({Key key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        return LoginAuthButton (
          onPressedCallback: vm.onPressedCallback,
        );
      },
    );
  }
}

class _ViewModel {
  final Function(String email, String password) onPressedCallback;

  _ViewModel({this.onPressedCallback});

  static _ViewModel fromStore(Store<AppState> store) {

    return _ViewModel(
      onPressedCallback: (String email, String password) {
        store.dispatch(LogIn(email: email, password: password));
      },
    );

  }
}