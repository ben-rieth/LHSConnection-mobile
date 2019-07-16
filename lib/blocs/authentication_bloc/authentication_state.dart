import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:Gamut/models/user.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super(props);
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';
}

class Authenticated extends AuthenticationState {
  final User userInfo;

  Authenticated(this.userInfo) : super([userInfo]);

  @override
  String toString() => 'Authenticated { User Information: $userInfo }';
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';
}
