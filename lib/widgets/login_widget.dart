import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:lhs_connections/widgets/custom_widgets/loading.dart';
import 'package:lhs_connections/widgets/home_widget.dart';
import 'package:lhs_connections/app_state_container.dart';
import 'package:lhs_connections/utils/uitlity_methods.dart';

class LoginPageViewModel {
  final Function() loginButtonPressed;

  LoginPageViewModel({
    this.loginButtonPressed,
  });
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;

  TextEditingController _usernameController;
  TextEditingController _passwordController;

  @override
  void initState() {

    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final container = AppStateContainer.of(context);

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
      validator: _emailValidator,
      autovalidate: _autoValidate,
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
      validator: _passwordValidator,
      autovalidate: _autoValidate,
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
        onPressed: () => _loginProcess(container),
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
        inAsyncCall: container.state.isLoading,
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

  String _emailValidator(String email) {
    if (email.isEmpty) {
      _autoValidate = true;
      return "Please enter in your Lindbergh email";
    } else if(!email.contains("@lindberghschools.ws")) {
      return "Email is not a Lindbergh email";
    }
  }

  String _passwordValidator(String password) {
    _autoValidate = true;
    if(password.isEmpty) {
      return "Please enter in 10-digit State ID";
    } else if (!UtilMethods.isNumeric(password)) {
      return "Password is not numeric";
    }
  }

  void _loginProcess(dynamic container) async {

    if(_formKey.currentState.validate()) {
      await container.logIntoFirebase(
          context,
          _usernameController.text,
          _passwordController.text);

      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (context) =>
                  Home()));

    }

  }

}