import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:lhs_connections/widgets/custom_widgets/loading.dart';
import 'package:lhs_connections/widgets/home_widget.dart';
import 'package:lhs_connections/app_state_container.dart';
import 'package:lhs_connections/utils/uitlity_methods.dart';
import 'package:lhs_connections/utils/loginStatus.dart';

///LoginPage is a StatefulWidget that contains the ui and client-side logic for
///   the logging in process of the app.
class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  ///A GlobalKey allows us to uniquely identify the form used later to get the
  ///   user's username and password and then allow us to validate the information
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ///If login fails, this String will contain the fail message depending on the
  ///   error. Can either be equal to "User Not Found" or "Password Incorrect"
  String logInFailMessage = "";

  ///boolean value stating whether or not the form should autovalidate while the
  ///   user is typing in the value
  bool _autoValidate = false;

  ///TextEditingControllers hold the text that is currently in the email or
  ///   password TextFormFields. The text can be accessed with _usernameController.text
  ///   or _passwordController.text
  TextEditingController _usernameController;
  TextEditingController _passwordController;

  ///Called only once, right before the build method is called
  @override
  void initState() {

    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  ///Builds the widget
  @override
  Widget build(BuildContext context) {
    ///Gets the AppStateContainer so you can change the AppState from LoginPage
    final container = AppStateContainer.of(context);

    ///A variable holding the LHSConnection logo above the login fields
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/lhsConnections.png'),
      ),
    );

    ///A variable holding TextFormField that the user will type their email into
    ///   to log in
    ///
    ///   controller (TextEditingController) -> holds the value inside the text form
    ///   validator -> method that will validate the email
    ///   autovalidate (bool) -> whether or not to validate the field as the user is typing
    ///   keyboardType (TextInputType) -> what type of keyboard is used, the current keyboard
    ///     here is especially for emails
    ///   autofocus (bool) -> whether or not the widget will focus on thsi field right when
    ///       it appears
    ///   textInputAction (TextInputAction) -> the type of button on the keyboard the user
    ///      will hit to submit the field, in this case it is a right facing arrow
    ///   decoration (InputDecoration) -> makes the field look pretty
    final emailForm = TextFormField(
      controller: _usernameController,
      validator: _emailValidator,
      autovalidate: _autoValidate,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: "Username",
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
      ),


    );

    ///A variable holding TextFormField that the user will type their password
    ///   into to log in
    ///
    ///   keyboardType (TypeInputType) -> sets a number field since the password is nummerical
    ///   textInputAction (TextInputAction) -> displays a right facing arrow button
    ///   obscureText (bool) -> sets it so the text appears as black dots
    final passwordForm = TextFormField(
      controller: _passwordController,
      validator: _passwordValidator,
      autovalidate: _autoValidate,
      autofocus: false,
      textInputAction: TextInputAction.go,
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Password",
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );

    ///A variable holding the button the user hits to login to the app
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

    ///The Scaffold takes all of the variable determined above and puts them into
    ///   a ui layout
    return Scaffold(
      backgroundColor: Colors.white,

      ///A custom widget that displays a loading circle if the app is loading
      body: LoadingScreen(
        inAsyncCall: container.state.isLoading,
        child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Center(
              child: ListView(
                physics: NeverScrollableScrollPhysics(), ///makes it so you cannot scroll the screen
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                children: <Widget>[
                  logo,
                  SizedBox(height: 48.0),
                  emailForm,
                  SizedBox(height: 8.0),
                  passwordForm,
                  SizedBox(height: 12.0),

                  ///A conditional that will only display the login fail message if the login
                  ///   status is not equal to success or not logged in; otherwise an empty
                  ///   container will be placed
                  container.state.loginStatus == LoginStatus.Success ||
                      container.state.loginStatus == LoginStatus.NotYetLoggedIn
                      ? Container() : makeLogInFailMessage(),


                  SizedBox(height: 12.0),
                  loginButton,
                  forgotLabel,
                ],
              ),
            )
        ),
      ),
    );
  }

  ///validates the entered email; if the validation fails autovalidate will be activated
  String _emailValidator(String email) {
    _autoValidate = true;
    if (email.isEmpty) {
      return "Please enter in your username";
    } /*else if(!email.contains("@lindberghschools.ws")) {
      return "Email is not a Lindbergh email";
    }*/
  }

  ///validates the entered password; if the validation fails autovalidate will be activated
  String _passwordValidator(String password) {
      _autoValidate = true;
    if(password.isEmpty) {
      return "Please enter in 10-digit State ID";

      ///UtilsMethods is located at lib/utils/uitlity_methods.dart
    } /*else if (!UtilMethods.isNumeric(password)) {
      return "Password is not numeric";
    }*/
  }

  ///This method builds the loginfailmessage if logging in fails
  Widget makeLogInFailMessage() {
    return Center(
      child: Text(
        logInFailMessage,
        style: TextStyle(
          color: Colors.red,
          fontSize: 18.0,
        ),
      ),
    );
  }

  ///This method will attempt to log the user in with the given credentials. IT is
  ///   called when the user hits the login button
  void _loginProcess(dynamic container) async {

    ///First the form will validate the fields, if the fields are successfully validated
    ///   the method continues.
    if(_formKey.currentState.validate()) {

      ///Calls to the logIntoFirebase method in the AppStateContainer and attempts
      ///   to login to the firebase and get the user's information from the Firestore
      await container.logIntoFirebase(
          context,
          "${_usernameController.text.trim()}@lindberghschools.ws",
          _passwordController.text);

      ///If LoginStatus equals Success, the app will redirect to the Home widget
      if (container.state.loginStatus == LoginStatus.Success) {
        Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                    Home()));
      } else {

        ///If login fails for some reason, the fail message will be set here
        if(container.state.loginStatus == LoginStatus.UserNotFound) {

          setState(() {
            logInFailMessage = "User not found. Please re-enter username";
            _usernameController.text = "";
            _passwordController.text = "";
          });

        } else if (container.state.loginStatus == LoginStatus.PasswordIncorrect) {
          setState(() {
            logInFailMessage = "Password Incorrect";
            _passwordController.text = "";
          });
        }

      }

    }

  }


}