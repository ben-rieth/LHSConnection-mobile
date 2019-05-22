import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:lhs_connections/blocs/search_bloc/bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  @override
  SearchState get initialState => NoSearch();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is QuerySearch) {



    }

  }
}