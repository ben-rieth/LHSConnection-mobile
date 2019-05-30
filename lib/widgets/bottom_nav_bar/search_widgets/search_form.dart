import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lhs_connections/repositories/algolia_repository.dart';
import 'package:lhs_connections/blocs/search_bloc/bloc.dart';
import 'package:lhs_connections/widgets/bottom_nav_bar/search_widgets/search_bar.dart';

class SearchForm extends StatefulWidget {
  final AlgoliaRepository _algoliaRepository;

  SearchForm({AlgoliaRepository algoliaRepository, Key key})
      : assert(algoliaRepository != null),
        _algoliaRepository = algoliaRepository,
        super(key: key);

  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm>
  with SingleTickerProviderStateMixin{

  final TextEditingController _searchBarController = TextEditingController();
  TabController _tabController;

  SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _searchBloc,
      listener: (BuildContext context, SearchState state) {

      },

      child: BlocBuilder(
        bloc: _searchBloc,
        builder: (BuildContext context, SearchState state) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: SearchBar(searchController: _searchBarController, onSearchChange: function),
                floating: true,
                expandedHeight: 110.0,
                backgroundColor: Colors.green,
                pinned: true,
                primary: true,
                snap: true,
                bottom: TabBar(
                  controller: _tabController,
                  //onTap: _newFilter,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey[600],
                  indicatorColor: Colors.white,
                  tabs: <Widget>[
                    //Tab(text: "EVERYTHING"),
                    Tab(text: "CLASSES"),
                    Tab(text: "CLUBS"),
                    Tab(text: "TUTORS"),
                  ],
                ),
              ),
            ],
          );

        },
      ),

    );
  }

  void function(String query) {

  }

}