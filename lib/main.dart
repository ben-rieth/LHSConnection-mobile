import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'package:lhs_connections/app_root.dart';
import 'package:lhs_connections/blocs/simple_bloc_delegate.dart';

main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(AppRoot());
}