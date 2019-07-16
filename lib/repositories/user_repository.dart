import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:Gamut/models/user.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference dbUsers = Firestore.instance.collection('students');

  UserRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp({String email, String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUserEmail() async {
    return (await _firebaseAuth.currentUser()).email;
  }

  Future<User> retrieveUserInformation() async {
    return await dbUsers
        .document(
          await getUserEmail().then((String email) {
            return email.substring(0, email.indexOf("@"));
          }))
        .get()
        .then((DocumentSnapshot ds) {
      return User.fromSnapshot(ds);
    });

  }
}
