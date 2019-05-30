import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lhs_connections/repositories/algolia_repository.dart';
import 'package:lhs_connections/blocs/search_bloc/bloc.dart';
import 'package:lhs_connections/widgets/bottom_nav_bar/search_widgets/search_bar.dart';
import 'package:lhs_connections/widgets/custom_widgets/loading.dart';
import 'package:lhs_connections/widgets/custom_widgets/right_arrow_card.dart';
import 'package:lhs_connections/models/class.dart';

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

  List<Class> areResultsShowing(SearchState state) {
    if(state is SuccessfulSearchClasses) {
      return state.returnedClasses;
    }
    return null;
  }



  bool isSearching(SearchState state) {
    return state is Searching;
  }

  @override
  void initState() {
    super.initState();
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _searchBloc,
      builder: (BuildContext context, SearchState state) {
        return LoadingScreen (
          inAsyncCall: isSearching(state),
          child: CustomScrollView(
            slivers: <Widget>[

              SliverAppBar(
                title: SearchBar(searchController: _searchBarController, onSearchChange: querySubmitted),
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
                    Tab(text: "CLASSES"),
                    Tab(text: "CLUBS"),
                    Tab(text: "TUTORS"),
                  ],
                ),
              ),

              areResultsShowing(state) != null ?
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {

                      Class currentClass = areResultsShowing(state)[index];
                      return RightArrowCard(
                        headerIcon: currentClass.icon,
                        title: currentClass.name,
                        subtitle: currentClass.tags.join(", "),
                      );

                    },
                    childCount: areResultsShowing(state).length,
                  ),
                ) : SliverList(delegate: SliverChildListDelegate([])),

            ],
          ),
        );
      },
    );
  }

  void querySubmitted(String query) {
    _searchBloc.dispatch(QuerySearchClasses(query: query));
  }

}