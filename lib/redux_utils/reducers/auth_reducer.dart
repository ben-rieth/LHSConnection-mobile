import 'package:firebase_auth/firebase_auth.dart';
import 'package:redux/redux.dart';

import 'package:lhs_connections/redux_utils/actions/auth_actions.dart';

final authReducer = combineReducers<FirebaseUser>([
  TypedReducer<FirebaseUser, LogInSuccessful>(_logIn),
  TypedReducer<FirebaseUser, LogOutSuccessful>(_logOut),
]);

FirebaseUser _logIn(FirebaseUser user, action) {
  return action.user;
}

Null _logOut(FirebaseUser user, action) {
  return null;
}