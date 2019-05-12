import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lhs_connections/blocs/authentication_bloc/bloc.dart';
import 'package:lhs_connections/repositories/user_repository.dart';
import 'package:lhs_connections/widgets/home_screen.dart';
import 'package:lhs_connections/widgets/login_widgets/splash_screen.dart';
import 'package:lhs_connections/blocs/simple_bloc_delegate.dart';

import 'package:lhs_connections/widgets/login_widgets/login_screen.dart';
import 'package:lhs_connections/widgets/login_widgets/login_form.dart';
import 'package:lhs_connections/blocs/login_bloc/bloc.dart';
import 'package:lhs_connections/widgets/login_widgets/login_button.dart';

main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(AppRoot());
}

class AppRoot extends StatefulWidget {
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  final UserRepository _userRepository = UserRepository();
  AuthenticationBloc _authenticationBloc;
  ThemeData _themeData = ThemeData(
    primaryColor: Colors.green,
  );

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.dispatch(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _authenticationBloc,
      child: MaterialApp(
        theme: _themeData,
        debugShowCheckedModeBanner: false,
        home: BlocBuilder(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is Uninitialized) {
              return SplashScreen();
            }
            if (state is Unauthenticated) {
              return LoginScreen(userRepository: _userRepository);
            }
            if (state is Authenticated) {
              return HomeScreen(name: state.displayName);
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }
}
