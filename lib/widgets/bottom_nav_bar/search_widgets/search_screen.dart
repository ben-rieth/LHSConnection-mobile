import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Gamut/repositories/algolia_repository.dart';
import 'package:Gamut/blocs/search_bloc/bloc.dart';
import 'package:Gamut/widgets/bottom_nav_bar/search_widgets/search_form.dart';

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
    return Scaffold(
      body: BlocProvider(
        bloc: _searchBloc,
        child: SearchForm(algoliaRepository: _algoliaRepository),
      ),
    );
  }

  @override
  void dispose() {
    _searchBloc.dispose();
    super.dispose();
  }

}