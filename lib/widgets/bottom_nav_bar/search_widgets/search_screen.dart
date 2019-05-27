import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lhs_connections/repositories/algolia_repository.dart';
import 'package:lhs_connections/blocs/search_bloc/bloc.dart';

class SearchScreen extends StatefulWidget {

  final AlgoliaRepository _algoliaRepository = AlgoliaRepository();

  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  SearchBloc _searchBloc;

  AlgoliaRepository get _algoliaRepository => widget._algoliaRepository;

  @override
  void initState() {
    super.initState();
    _searchBloc = SearchBloc(
      algoliaRepository: _algoliaRepository,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

  @override
  void dispose() {
    _searchBloc.dispose();
    super.dispose();
  }

}