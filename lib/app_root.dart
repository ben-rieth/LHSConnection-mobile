import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Gamut/blocs/authentication_bloc/bloc.dart';
import 'package:Gamut/repositories/user_repository.dart';
import 'package:Gamut/widgets/home_screen.dart';
import 'package:Gamut/widgets/login_widgets/splash_screen.dart';

import 'package:Gamut/widgets/login_widgets/login_screen.dart';
import 'package:Gamut/widgets/login_widgets/login_form.dart';
import 'package:Gamut/blocs/login_bloc/bloc.dart';
import 'package:Gamut/widgets/login_widgets/login_button.dart';
import 'package:Gamut/widgets/onboarding/intro_slideshow.dart';

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
              return Home(user: state.userInfo);
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
