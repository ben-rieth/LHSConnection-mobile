import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:lhs_connections/utils/app_state.dart';
import 'package:lhs_connections/models/User.dart';
import 'package:lhs_connections/utils/grade_level.dart';
import 'package:lhs_connections/utils/loginStatus.dart';

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

      state = AppState.initalState();
      initUser();
    }

    super.initState();
  }

  Future<Null> initUser() async {
    await _auth.signOut();
    user = await _ensureLoggedInOnStartUp();
    if (user == null) {
      setState(() {
        state.isLoading = false;
      });
    } else {

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

    print("Second HERE");

    try {
      user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      print("Third HERE");

      if(user != null) {
        final QuerySnapshot result = await dbUsers.where('id', isEqualTo: user.uid).getDocuments();
        final List<DocumentSnapshot> documents = result.documents;

        print("Fourth HERE");

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

        print("Fifth HERE");

        User userInformation = await _createUserInformation();

        print("USERINFO: $userInformation");

        setState(() {
          state.isLoading = false;
          state.currentUser = user;
          state.userInformation = userInformation;
          state.loginStatus = LoginStatus.Success;
        });

      }
    } catch (e) {
      print("Printing error");

      if (e.toString().contains("ERROR_USER_NOT_FOUND")) {
        setState(() {
          state.isLoading = false;
          state.loginStatus = LoginStatus.UserNotFound;
        });
      } else if (e.toString().contains("ERROR_WRONG_PASSWORD")) {
        setState(() {
          state.isLoading = false;
          state.loginStatus = LoginStatus.PasswordIncorrect;
        });
      }


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