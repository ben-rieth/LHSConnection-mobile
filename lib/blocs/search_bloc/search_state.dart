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

class SuccessfulSearchClasses extends SearchState {

  final List<Class> returnedClasses;
  final int numResults;

  SuccessfulSearchClasses({this.returnedClasses, this.numResults}) : super([returnedClasses, numResults]);

  @override
  String toString() => 'Search for Classes Successful';
}

class NothingFound extends SearchState {

  @override
  String toString() => 'Nothing Found';
}