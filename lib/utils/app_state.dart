import 'package:firebase_auth/firebase_auth.dart';

import 'package:lhs_connections/models/User.dart';
import 'package:lhs_connections/utils/loginStatus.dart';

class AppState {

  bool isLoading;

  LoginStatus loginStatus;

  FirebaseUser currentUser;
  User userInformation;

  AppState({
    this.isLoading = false,
    this.currentUser,
    this.userInformation,
    this.loginStatus,
  });

  factory AppState.initalState() => new AppState(
      isLoading: true,
      loginStatus: LoginStatus.NotYetLoggedIn);

}