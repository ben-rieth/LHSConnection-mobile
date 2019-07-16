import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gamut/repositories/user_repository.dart';
import 'package:Gamut/blocs/authentication_bloc/bloc.dart';

import 'package:Gamut/widgets/login_widgets/login_screen.dart';
import 'package:Gamut/widgets/login_widgets/login_form.dart';
import 'package:Gamut/blocs/login_bloc/bloc.dart';
import 'package:Gamut/widgets/login_widgets/login_button.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _loginBloc,
      listener: (BuildContext context, LoginState state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Login Failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Logging In...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedIn());
        }
      },
      child: BlocBuilder(
        bloc: _loginBloc,
        builder: (BuildContext context, LoginState state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
            child: Form(
              child: ListView(
                children: <Widget>[

                  SizedBox(height: 10.0,),

                  Hero(
                  tag: 'hero',
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 48.0,
                      child: Image.asset('assets/lhsConnections.png'),
                    ),
                  ),

                  SizedBox(height: 64.0),

                  TextFormField(
                    controller: _emailController,
                    autovalidate: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Username",
                      contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
                    ),
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),

                  SizedBox(height: 10.0),

                  TextFormField(
                    controller: _passwordController,
                    autovalidate: false,
                    autocorrect: false,
                    textInputAction: TextInputAction.go,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
                    ),
                    validator:  (_) {
                      return !state.isEmailValid ? 'Invalid Password' : null;
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 50.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.all(15.0),
                      color: Colors.green,
                      child: Text(
                          "Log In",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0)
                      ),
                      onPressed: isLoginButtonEnabled(state)
                          ? _onFormSubmitted
                          : null,
                    ),
                  )

                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.dispatch(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.dispatch(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.dispatch(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
