import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lhs_connections/repositories/algolia_repository.dart';
import 'package:lhs_connections/blocs/search_bloc/bloc.dart';
import 'package:lhs_connections/widgets/bottom_nav_bar/search_widgets/search_bar.dart';
import 'package:lhs_connections/widgets/custom_widgets/loading.dart';
import 'package:lhs_connections/widgets/custom_widgets/basic_card.dart';
import 'package:lhs_connections/models/class.dart';
import 'package:lhs_connections/widgets/class_club_widgets/results_puruse_screen.dart';

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

  SuccessfulSearchClasses areResultsShowing(SearchState state) {
    if(state is SuccessfulSearchClasses) {
      return state;
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
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                      child: Text(
                        areResultsShowing(state).numResults.toString() + " Results Found",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(bottom: 10.0),
                      color: Colors.grey[400],
                      width: MediaQuery.of(context).size.width,
                      height: 2.0,
                    ),

                  ]),
                ) : SliverList(delegate: SliverChildListDelegate([])),


              areResultsShowing(state) != null ?
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {

                      Class currentClass = areResultsShowing(state).returnedClasses[index];

                      return BasicCard.rightArrowCard(
                          currentClass.icon,
                          currentClass.name,
                          currentClass.tags.join(", "),

                          () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResultsPuruseScreen(
                                      classes: areResultsShowing(state).returnedClasses,
                                      initialPageIndex: index,
                                    )));
                          }

                      );

                    },
                    childCount: areResultsShowing(state).returnedClasses.length,
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

  void classTapped(Class tapped) {

  }

}