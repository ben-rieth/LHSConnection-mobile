import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:redux/redux.dart';

import 'package:lhs_connections/redux_utils/app_state.dart';
import 'package:lhs_connections/redux_utils/actions/auth_actions.dart';

middleware(Store<AppState> store, action, NextDispatcher next) {

  if(action is LogIn) {
    _handleLogInWithEmailAndPassword(store, action);
  }

  next(action);
}

_handleLogInWithEmailAndPassword(Store<AppState> store, LogIn action) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference dbUsers = Firestore.instance.collection('users');

  FirebaseUser user;

  try {
    user = await _auth.signInWithEmailAndPassword(email: action.email, password: action.password);
  } catch (error) {
    store.dispatch(LogInFail(action));
  }

  if(user != null) {
    final QuerySnapshot result = await dbUsers.where('id', isEqualTo: user.uid).getDocuments();
    final List<DocumentSnapshot> documents = result.documents;

    if(documents.length == 0) {
      dbUsers
        .document(user.uid)
        .setData({
          'email': action.email,
          'uname': action.email.substring(2, action.email.indexOf("@")),
          'id': user.uid,
      });
    }
  }

  store.dispatch(LogInSuccessful(user: user));

}