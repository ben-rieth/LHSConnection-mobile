import 'package:flutter/material.dart';

//import 'package:lhs_connections/widgets/home_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _usernameController;
  TextEditingController _passwordController;

  FocusNode usernameNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  @override
  void initState() {

    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

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
      focusNode: usernameNode,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: "Lindbergh Email",
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );

    final passwordForm = TextFormField(
      controller: _passwordController,
      autofocus: false,
      focusNode: passwordNode,
      textInputAction: TextInputAction.go,
      obscureText: true,
      onEditingComplete: _onUsernameSubmit,
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
        onPressed: _login,
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
      body: Center(
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
      ),
    );
  }

  void _login() {
    Navigator.pushReplacementNamed(context, "/home");
  }

  void _onUsernameSubmit() {
    //if(_passwordController.text == "") {
      FocusScope.of(context).requestFocus(passwordNode);
    //}
  }
}