import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SearchState extends Equatable {
  SearchState([List props = const []]) : super(props);
}

class NoSearch extends SearchState {
  @override
  String toString() => 'Nothing Searched';
}

class SuccessfulSearch extends SearchState {

  @override
  String toString() => 'Search Successful';
}

class NothingFound extends SearchState {

  @override
  String toString() => 'Nothing Found';
}