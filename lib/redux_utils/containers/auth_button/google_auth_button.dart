import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class LoginAuthButton extends StatelessWidget {
  final Function onPressedCallback;

  // Passed in from Container
  LoginAuthButton({
    this.onPressedCallback,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 50.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () => onPressedCallback(),
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
  }
}