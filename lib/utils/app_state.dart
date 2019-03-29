import 'package:firebase_auth/firebase_auth.dart';

import 'package:lhs_connections/models/User.dart';

class AppState {

  bool isLoading;
  bool isUserNotFound;
  bool isEmailMalformed;
  bool isPasswordWrong;

  FirebaseUser currentUser;
  User userInformation;

  AppState({
    this.isLoading = false,
    this.currentUser,
    this.userInformation,
  });

  factory AppState.loading() => new AppState(isLoading: true);
}