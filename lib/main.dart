import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'package:Gamut/app_root.dart';
import 'package:Gamut/blocs/simple_bloc_delegate.dart';

main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(AppRoot());
}