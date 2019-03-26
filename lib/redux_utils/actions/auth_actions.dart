import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogIn {
  final String email;
  final String password;

  LogIn({this.email, this.password});
}

class LogInSuccessful {
  final FirebaseUser user;

  LogInSuccessful({ @required this.user});

  @override
  String toString() {
    return 'LogIn{user: $user}';
  }
}

class LogInFail {
  final dynamic error;

  LogInFail(this.error);

  @override
  String toString() {
    return 'LogIn{There was an error logging in: $error}';
  }
}

class LogOut {}

class LogOutSuccessful {
  LogOutSuccessful();

  @override
  String toString() {
    return 'LogOut{user: null}';
  }
}