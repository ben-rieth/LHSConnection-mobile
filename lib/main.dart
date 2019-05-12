import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lhs_connections/app_root.dart';
import 'package:lhs_connections/blocs/authentication_bloc/bloc.dart';
import 'package:lhs_connections/repositories/user_repository.dart';
import 'package:lhs_connections/widgets/home_screen.dart';
import 'package:lhs_connections/widgets/login_widgets/splash_screen.dart';
import 'package:lhs_connections/blocs/simple_bloc_delegate.dart';
import 'package:lhs_connections/widgets/bottom_nav_bar/account_screen.dart';

import 'package:lhs_connections/widgets/login_widgets/login_screen.dart';
import 'package:lhs_connections/widgets/login_widgets/login_form.dart';
import 'package:lhs_connections/blocs/login_bloc/bloc.dart';
import 'package:lhs_connections/widgets/login_widgets/login_button.dart';

main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(AppRoot());
}