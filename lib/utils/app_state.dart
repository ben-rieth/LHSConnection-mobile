import 'package:firebase_auth/firebase_auth.dart';

import 'package:lhs_connections/models/User.dart';
import 'package:lhs_connections/utils/loginStatus.dart';
import 'package:lhs_connections/models/Class.dart';
import 'package:lhs_connections/models/Club.dart';

class AppState {

  bool isLoading;

  LoginStatus loginStatus;

  FirebaseUser currentUser;
  User userInformation;

  Class currentClass;
  Club currentClub;

  AppState({
    this.isLoading = false,
    this.currentUser,
    this.userInformation,
    this.loginStatus,
    this.currentClub,
    this.currentClass
  });

  factory AppState.initalState() => new AppState(
      isLoading: true,
      loginStatus: LoginStatus.NotYetLoggedIn,
      currentClass: null,
      currentClub: null);

}