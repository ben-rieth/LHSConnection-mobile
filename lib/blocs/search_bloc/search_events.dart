import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SearchEvent extends Equatable {
  SearchEvent([List props = const []]) : super(props);
}

class QuerySearch extends SearchEvent {
  final String query;

  QuerySearch({this.query}) : super([query]);

}