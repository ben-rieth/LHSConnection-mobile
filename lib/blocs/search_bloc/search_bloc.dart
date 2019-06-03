import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:algolia/algolia.dart';

import 'package:lhs_connections/blocs/search_bloc/bloc.dart';
import 'package:lhs_connections/repositories/algolia_repository.dart';
import 'package:lhs_connections/models/class.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  AlgoliaRepository _algoliaRepository;

  SearchBloc({
    @required AlgoliaRepository algoliaRepository,
  })  : assert(algoliaRepository != null),
        _algoliaRepository = algoliaRepository;

  @override
  SearchState get initialState => NoSearch();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is QuerySearchClasses) {

      List<Class> results = [];

      yield Searching();

      AlgoliaQuerySnapshot snap = await _algoliaRepository.searchIndex('classes', event.query);

      if(snap.nbHits == 0) {
        yield NothingFound();
      } else {

        snap.hits.forEach((AlgoliaObjectSnapshot aos) {
          results.add(Class.fromMap(aos.data));
        });

        yield SuccessfulSearchClasses(returnedClasses: results, numResults: results.length);

      }


    }

  }

}