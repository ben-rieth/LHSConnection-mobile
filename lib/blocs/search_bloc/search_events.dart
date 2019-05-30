import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SearchEvent extends Equatable {
  SearchEvent([List props = const []]) : super(props);
}

class QuerySearchClasses extends SearchEvent {
  final String query;

  QuerySearchClasses({this.query}) : super([query]);

}

class QuerySearchClubs extends SearchEvent {
  final String query;

  QuerySearchClubs({this.query}) : super([query]);

}

class QuerySearchTutors extends SearchEvent {
  final String query;

  QuerySearchTutors({this.query}) : super([query]);

}