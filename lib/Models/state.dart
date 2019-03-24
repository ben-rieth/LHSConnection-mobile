import 'package:firebase_auth/firebase_auth.dart';

import 'package:lhs_connections/models/User.dart';

class StateModel {
  bool isLoading;
  FirebaseUser firebaseUserAuth;
  User user;

  StateModel({
    this.isLoading = false,
    this.firebaseUserAuth,
    this.user
  });
}