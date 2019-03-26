import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lhs_connections/widgets/custom_widgets/loading.dart';
import 'package:lhs_connections/widgets/home_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final CollectionReference dbUsers = Firestore.instance.collection("users");
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  SharedPreferences prefs;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;
  bool _loadingVisible = false;
  //bool _isLoggedIn = false;

  TextEditingController _usernameController;
  TextEditingController _passwordController;

  FirebaseUser currentUser;

  @override
  void initState() {

    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    //isSignedIn();

    super.initState();
  }

  /*void isSignedIn() async {
    this.setState(() {
      _loadingVisible = true;
    });

    prefs = await SharedPreferences.getInstance();
    _isLoggedIn = await _auth.currentUser() == null;

    if(_isLoggedIn) {
      Navigator.pushReplacementNamed(context, "/home");
    }

    this.setState(() {
      _loadingVisible = false;
    });
  }*/

  /*Future<Null> handleSignIn(String email, String password) async {
    prefs = await SharedPreferences.getInstance();

    this.setState(() {
      _loadingVisible = true;
    });

    FirebaseUser user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    print("HERE1");
    if(user != null) {
      final QuerySnapshot result = await dbUsers.where('id', isEqualTo: user.uid).getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      print("Here2");
      if(documents.length == 0) {

        dbUsers
            .document(user.uid)
            .setData({
              'email': email,
              'uname': email.substring(2,email.indexOf("@")),
              'id': user.uid,
        });

        currentUser = user;
        await prefs.setString('id', currentUser.uid);
        await prefs.setString('email', currentUser.email);
        //await prefs.setString('uname', currentUser.);
        assert(currentUser != null);

      } else {
        currentUser = user;
        print("CURRENT USER! = $currentUser" );
        await prefs.setString('id', documents[0]['id']);
        await prefs.setString('email', documents[0]['email']);
        await prefs.setString('uname', documents[0]['uname']);
      }

      this.setState(() {
        _loadingVisible = false;
      });

      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
              Home(currentUserId: currentUser.uid)));
    } else {
      this.setState(() {
        _loadingVisible = false;
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/lhsConnections.png'),
      ),
    );

    final emailForm = TextFormField(
      controller: _usernameController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: "Lindbergh Email",
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );

    final passwordForm = TextFormField(
      controller: _passwordController,
      keyboardType: TextInputType.number,
      autofocus: false,
      textInputAction: TextInputAction.go,
      obscureText: true,
      decoration: InputDecoration(
        hintText: "State Id",
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );

    final loginButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 50.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () => _goToHomeScreen,
            /*handleSignIn(
         _usernameController.text,
          _passwordController.text,
        ),*/
        padding: const EdgeInsets.all(15.0),
        color: Colors.green,
        child: Text(
            "Log In",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.0)
        ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        "Forgot password?",
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingScreen(
        inAsyncCall: _loadingVisible,
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Center(
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                logo,
                SizedBox(height: 48.0),
                emailForm,
                SizedBox(height: 8.0),
                passwordForm,
                SizedBox(height: 24.0),
                loginButton,
                forgotLabel,
              ],
            ),
          )
        ),
      ),
    );
  }

  void _goToHomeScreen() {
    Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
                Home()));
  }
}