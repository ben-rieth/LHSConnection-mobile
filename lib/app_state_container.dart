import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:lhs_connections/utils/app_state.dart';
import 'package:lhs_connections/models/User.dart';
import 'package:lhs_connections/utils/grade_level.dart';

class AppStateContainer extends StatefulWidget {
  final AppState state;
  final Widget child;

  AppStateContainer({
    @required this.child,
    this.state
  });

  static _AppStateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
        as _InheritedStateContainer)
        .data;
  }

  @override
  _AppStateContainerState createState() => new _AppStateContainerState();
}

class _AppStateContainerState extends State<AppStateContainer> {
  AppState state;

  FirebaseUser user;
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference dbUsers = Firestore.instance.collection('users');

  @override
  void initState() {

    DateUtil.checkHeaderUpdate();

    if(widget.state != null) {
      state = widget.state;
    } else {

      state = AppState.loading();

      initUser();
    }

    super.initState();
  }

  Future<Null> initUser() async {
    user = await _ensureLoggedInOnStartUp();
    if (user == null) {

      Navigator.pushReplacementNamed(context, "/login");

    } else {
      setState(() {
        state.isLoading = false;
      });
    }
  }

  Future<FirebaseUser> _ensureLoggedInOnStartUp() async {
    user = await _auth.currentUser();

    if(user == null) {
      //action if user is null
    }

    return user;
  }

  Future<Null> logIntoFirebase(BuildContext context, String email, String password) async {

    setState(() {
      state.isLoading = true;
    });

    if(user == null) {
      //what
    }

    FirebaseUser firebaseUser;

    try {
      firebaseUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print("Here");
      if(user != null) {
        final QuerySnapshot result = await dbUsers.where('id', isEqualTo: user.uid).getDocuments();
        final List<DocumentSnapshot> documents = result.documents;

        if(documents.length == 0) {
          dbUsers
              .document(user.uid)
              .setData({
                'email': email,
                'id': user.uid,
                'name': email.substring(2, email.indexOf("@", 2)),
                'gradeLevel' : DateUtil.getGradeLevel( int.parse(email.substring(0, 2)) )
          });
        }

        User userInformation = await _createUserInformation();

        print("USERINFO: $userInformation");

        setState(() {
          state.isLoading = false;
          state.currentUser = firebaseUser;
          state.userInformation = userInformation;
        });

        /*Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                    Home()));*/

      }
    } catch (e) {
      print("Printing error");

      setState(() {
        state.isLoading = false;
      });

      if (e.toString().contains("USER_NOT_FOUND")) {

      }
      return null;
    }
  }

  Future<User> _createUserInformation() async {
    User userInfo;
    userInfo = await dbUsers.document(user.uid).get().then((DocumentSnapshot ds) {
      return User.fromSnapshot(ds);
    });

    return userInfo;
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {

  final _AppStateContainerState data;

  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}