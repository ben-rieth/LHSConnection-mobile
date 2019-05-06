import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:algolia/algolia.dart';
import 'dart:async';

import 'package:lhs_connections/models/Club.dart';
import 'package:lhs_connections/models/Class.dart';
import 'package:lhs_connections/models/dummy_data/dummy_clubs.dart';
import 'package:lhs_connections/models/dummy_data/dummy_classes.dart';
import 'package:lhs_connections/widgets/class_clubs_widgets/potential_class_widget.dart';
import 'package:lhs_connections/widgets/class_clubs_widgets/potential_club_widget.dart';
import 'package:lhs_connections/app_state_container.dart';
import 'package:lhs_connections/widgets/custom_widgets/loading.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search>
    with SingleTickerProviderStateMixin{

  static final Algolia algolia = Algolia.init(
    applicationId: "LJ5RB82WYM",
    apiKey: "0e54c75a00a0ce3e6eb630873b573c25"
  );

  final CollectionReference dbClasses = Firestore.instance.collection("classes");
  var container;


  List<Club> clubs;

  List<Club> _filteredClubs = List<Club>();
  List<Class> _filteredClasses = List<Class>();

  //List<Widget> _filteredItems = List<Widget>();

  bool _resultsAreVisible = false;
  bool _areClassesVisible = true;
  bool _areClubsVisible = false;
  bool _noClubsFound = false;
  bool _noClassesFound = false;

  TextEditingController editingController = new TextEditingController();

  TabController _tabController;
  ScrollController _scrollController;

  @override
  void initState() {
    clubs = DummyClubs().dummyClubs;
    _filteredClubs.addAll(clubs);

    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController(initialScrollOffset: 0.0);
    _scrollController.addListener(_onScroll);


    super.initState();
  }

  @override
  void dispose() {

    _tabController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    container = AppStateContainer.of(context);

    final searchBar = Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
      child: TextField(
        autofocus: true,
        onSubmitted: _onSearchChange,
        controller: editingController,
        style: TextStyle(
          fontSize: 20.0,
          //height: .5,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(11.0),
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          hintText: "Search for Classes and Clubs",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
        ),
      ),
    );

    return SwipeDetector(
      onSwipeLeft: _swipeLeft,
      onSwipeRight: _swipeRight,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[

          SliverAppBar(
            title: searchBar,
            floating: true,
            expandedHeight: 120.0,
            backgroundColor: Colors.grey[350],
            pinned: true,
            primary: true,
            snap: true,
            bottom: TabBar(
              controller: _tabController,
              onTap: _newFilter,
              labelColor: Colors.green,
              unselectedLabelColor: Colors.white,
              indicatorColor: Colors.lightGreen,
              tabs: <Widget>[
                //Tab(text: "EVERYTHING"),
                Tab(text: "CLASSES"),
                Tab(text: "CLUBS"),
              ],
            ),
          ),

          //container.state.isLoading ? Text("Loading...") : Container(),

          _areClassesVisible && _resultsAreVisible ?
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _areClubsVisible ? makeHeader("Classes") : new Container(),
                _noClassesFound ? makeNothingFoundStatement("Classes", editingController.text) : new Container(),
              ],
            ),
          ) : SliverList(delegate: SliverChildListDelegate([])),

          _areClassesVisible && _resultsAreVisible && !_noClassesFound ?
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return makeCard(_filteredClasses[index]);
              },
              childCount: _filteredClasses.length,
            ),
          ): SliverList(delegate: SliverChildListDelegate([])),

          _areClubsVisible && _resultsAreVisible ?
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _areClassesVisible ? makeHeader("Clubs") : new Container(),
                _noClubsFound ? makeNothingFoundStatement("Clubs", editingController.text) : new Container(),
              ],
            ),
          ) : SliverList(delegate: SliverChildListDelegate([])),

          _areClubsVisible && _resultsAreVisible && !_noClubsFound ?
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return makeCard(_filteredClubs[index]);
              },
              childCount: _filteredClubs.length,
            ),
          ) : SliverList(delegate: SliverChildListDelegate([])),

        ],
      ),

    );
  }

  Card makeCard(dynamic act) {

    String tagSubtitle = makeTagSubtitle(act);

    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),

        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.grey[350]))),
            child: Icon(act.icon, color: Colors.grey[350]),
          ),

          title: Text(
            act.name,
            style:
                TextStyle(color: Colors.grey[350], fontWeight: FontWeight.bold),
          ),

          subtitle: Text(
            tagSubtitle,
            style: TextStyle(color: Colors.grey[350]),
          ),

          trailing: Icon(Icons.keyboard_arrow_right,
              color: Colors.grey[350], size: 30.0),

          onTap: () {
            if(act is Class) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PotentialClassPage(potentialClass: act)));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PotentialClubPage(potentialClub: act)));
            }
          },
        ),
      ),
    );
  }

  void _onScroll() {

  }

  void _newFilter(int index) {
    setState(() {
      if (index == 0) {
        _areClassesVisible = true;
        _areClubsVisible = false;
      } else if (index == 1) {
        _areClassesVisible = false;
        _areClubsVisible = true;
      } else {
        _areClassesVisible = true;
        _areClubsVisible = true;
      }
    });
  }

  void _swipeLeft() {
    setState(() {
      if(_tabController.index+1 <= 1) {
        _tabController.animateTo(_tabController.index+1);
        _newFilter(_tabController.index);
      }
    });
  }

  void _swipeRight() {
    setState(() {
      if(_tabController.index-1 >= 0) {
        _tabController.animateTo(_tabController.index-1);
        _newFilter(_tabController.index);
      }
    });
  }

  Future<Null> _onSearchChange(String query) async {

    if (_areClubsVisible && _areClassesVisible) {
      await _filterClasses(query);
      _filterClubs(query);

    } else if (_areClassesVisible && !_areClubsVisible)
      await _filterClasses(query);

    else if (!_areClassesVisible && _areClubsVisible)
    _filterClubs(query);
  }

  Future<Null> _getClasses(AlgoliaQuery query) async {
    //container.startLoading();

    List<Class> results = List<Class>();

    AlgoliaQuerySnapshot snap = await query.getObjects();

    if(snap.nbHits == 0) {
      setState(() {
        _noClassesFound = true;
      });
    } else {

      snap.hits.forEach((AlgoliaObjectSnapshot aos) {
        print(Class.fromMap(aos.data).toString());

        results.add(Class.fromMap(aos.data));
      });

      setState(() {
        _noClassesFound = false;
        _resultsAreVisible = true;

        _filteredClasses.clear();
        _filteredClasses.addAll(results);
      });
    }

    //container.stopLoading();
  }

  Future<Null> _filterClasses(String queryS) async {

    AlgoliaQuery query = algolia.instance.index('classes').search(queryS);

    await _getClasses(query);

    print(_filteredClasses);

  }


  /*Future<Null> _filteClasses(String query) async {

    /*final QuerySnapshot result = await dbClasses
        .where(query, isEqualTo: name).getDocuments();*/

    List<Class> dummySearchList = List<Class>();
    dummySearchList.addAll(classes);

    if(query.isNotEmpty) {
      List<Class> dummyListData = List<Class>();
      dummySearchList.forEach((classOption) {
        String name = classOption.name.toLowerCase();

        if(name.contains(query)) {
          dummyListData.add(classOption);
        }

        classOption.tags.forEach((tag) {
          String currTag = tag.toLowerCase();

          if (currTag.contains(query)) {
            if(!dummyListData.contains(classOption)) {
              dummyListData.add(classOption);
            }
          }
        });

        setState(() {
          _resultsAreVisible = true;
          if(dummyListData.length == 0) {
            _noClassesFound = true;
          } else {
            _noClassesFound = false;

            _filteredClasses.clear();
            _filteredClasses.addAll(dummyListData);
          }
        });
      });
    } else {
      setState(() {
        _resultsAreVisible = false;
        classes.clear();
        classes.addAll(dummySearchList);
      });
    }
  }*/

  void _filterClubs(String query) {
    List<Club> dummySearchList = List<Club>();
    dummySearchList.addAll(clubs);

    if(query.isNotEmpty) {
      List<Club> dummyListData = List<Club>();
      dummySearchList.forEach((clubOption) {
        String name = clubOption.name.toLowerCase();

        if(name.contains(query)) {
          dummyListData.add(clubOption);
        }

        clubOption.tags.forEach((tag) {
          String currTag = tag.toLowerCase();

          if (currTag.contains(query)) {
            if(!dummyListData.contains(clubOption))
              dummyListData.add(clubOption);
          }
        });

        setState(() {
          _resultsAreVisible = true;
          if(dummyListData.length == 0) {
            _noClubsFound = true;
          } else {
            _noClubsFound = false;

            _filteredClubs.clear();
            _filteredClubs.addAll(dummyListData);
          }
        });
      });
    } else {
      setState(() {
        _resultsAreVisible = false;
        clubs.clear();
        clubs.addAll(dummySearchList);
      });
    }
  }



  Container makeHeader(String heading) => Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    //color: Colors.grey[350],
    child: Text(
      heading,
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w300,
          fontSize: 30.0),
    ),
  );


  Container makeNothingFoundStatement(String heading, String query) =>
    Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        "No $heading found under \'$query\'",
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w300,
            fontSize: 20.0),
      ),
    );

  String makeTagSubtitle(dynamic act) {
    String tagSubtitle = "";

    act.tags.forEach((tag) {
      tagSubtitle += "$tag, ";
    });

    tagSubtitle = tagSubtitle.trim();
    tagSubtitle = tagSubtitle.substring(0, tagSubtitle.length - 1);

    return tagSubtitle;
  }
}
