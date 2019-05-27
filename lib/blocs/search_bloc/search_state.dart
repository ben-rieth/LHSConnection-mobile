import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:lhs_connections/models/class.dart';

@immutable
abstract class SearchState extends Equatable {
  SearchState([List props = const []]) : super(props);
}

class NoSearch extends SearchState {
  @override
  String toString() => 'Nothing Searched';
}

class Searching extends SearchState {
  @override
  String toString() => 'Searching';
}

class SuccessfulSearch extends SearchState {

  final List<Class> returnedClasses;

  SuccessfulSearch({this.returnedClasses}) : super([returnedClasses]);

  @override
  String toString() => 'Search Successful';
}

class NothingFound extends SearchState {

  @override
  String toString() => 'Nothing Found';
}