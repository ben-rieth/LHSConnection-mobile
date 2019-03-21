import 'package:flutter/material.dart';

import 'package:lhs_connections/models/Club.dart';
import 'package:lhs_connections/models/Class.dart';
import 'package:lhs_connections/models/dummy_data/dummy_clubs.dart';
import 'package:lhs_connections/models/dummy_data/dummy_classes.dart';
import 'package:lhs_connections/widgets/class_clubs_widgets/potential_class_widget.dart';
import 'package:lhs_connections/widgets/class_clubs_widgets/potential_club_widget.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search>
    with SingleTickerProviderStateMixin{
  List<Club> clubs;
  List<Class> classes;

  List<Club> _filteredClubs = List<Club>();
  List<Class> _filteredClasses = List<Class>();

  //List<Widget> _filteredItems = List<Widget>();

  String dropdownValue = "Any";
  bool _resultsAreVisible = false;
  bool _areClassesVisible = true;
  bool _areClubsVisible = true;
  bool _noClubsFound = false;
  bool _noClassesFound = false;

  TextEditingController editingController = new TextEditingController();

  TabController _tabController;
  ScrollController _scrollController;

  @override
  void initState() {
    clubs = DummyClubs().dummyClubs;
    _filteredClubs.addAll(clubs);

    classes = DummyClasses().dummyClasses;
    _filteredClasses.addAll(classes);

    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController(initialScrollOffset: 0.0);
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[

        SliverAppBar(
          title: makeSearchBar(),
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
            tabs: <Widget>[
              Tab(text: "EVERYTHING"),
              Tab(text: "CLASSES"),
              Tab(text: "CLUBS"),
            ],
          ),
        ),

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
      if (index == 1) {
        _areClassesVisible = true;
        _areClubsVisible = false;
      } else if (index == 2) {
        _areClassesVisible = false;
        _areClubsVisible = true;
      } else {
        _areClassesVisible = true;
        _areClubsVisible = true;
      }
    });
  }

  void _onSearchChange(String query) {
    query = query.toLowerCase();
    query = query.trim();

    _searchSort(query);
  }

  void _searchSort(String query) {
    if (_areClubsVisible && _areClassesVisible) {
      _filterClasses(query);
      _filterClubs(query);

    } else if (_areClassesVisible && !_areClubsVisible)
      _filterClasses(query);

    else if (!_areClassesVisible && _areClubsVisible)
      _filterClubs(query);
  }

  void _filterClasses(String query) {
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
  }

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

  Padding makeSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
      child: TextField(
        autofocus: true,
        onChanged: _onSearchChange,
        controller: editingController,
        style: TextStyle(
          fontSize: 20.0,
          //height: .5,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(13.0),
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          hintText: "Search",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
        ),
      ),
    );
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
