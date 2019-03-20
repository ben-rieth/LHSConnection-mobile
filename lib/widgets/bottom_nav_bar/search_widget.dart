import 'package:flutter/material.dart';

import 'package:lhs_connections/models/Club.dart';
import 'package:lhs_connections/models/Class.dart';
import 'package:lhs_connections/models/dummy_data/dummy_clubs.dart';
import 'package:lhs_connections/models/dummy_data/dummy_classes.dart';
import 'package:lhs_connections/widgets/class_clubs_widgets/potential_class_widget.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
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

  @override
  void initState() {
    clubs = DummyClubs().dummyClubs;
    _filteredClubs.addAll(clubs);

    classes = DummyClasses().dummyClasses;
    _filteredClasses.addAll(classes);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[

        SliverAppBar(
          //title: Text("Search", style: TextStyle(color: Colors.black)),
          floating: true,
          expandedHeight: 140.0,
          backgroundColor: Colors.grey,
          flexibleSpace: Column(
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 8.0, left: 8.0, right: 8.0),
                child: TextField(
                  autofocus: true,
                  onChanged: _onSearchChange,
                  controller: editingController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  ),
                ),
              ),

              Center(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    onChanged: _newFilter,
                    items: <String>["Any", "Classes", "Clubs", "People"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),

            ],
          ),
        ),

        _areClassesVisible && _resultsAreVisible ?
        SliverList(
          delegate: SliverChildListDelegate(
            [
              makeHeader("Classes"),
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
              makeHeader("Clubs"),
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
            color: Colors.lightGreenAccent,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),

        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.grey))),
            child: Icon(act.icon, color: Colors.grey),
          ),

          title: Text(
            act.name,
            style:
                TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),

          subtitle: Text(
            tagSubtitle,
            style: TextStyle(color: Colors.grey),
          ),

          trailing: Icon(Icons.keyboard_arrow_right,
              color: Colors.grey, size: 30.0),

          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PotentialClassPage(potentialClass: act)));
          },
        ),
      ),
    );
  }

  void _newFilter(String newValue) {
    setState(() {
      dropdownValue = newValue;

      if (newValue == "Classes") {
        _areClassesVisible = true;
        _areClubsVisible = false;
      } else if (newValue == "Clubs") {
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

  Container makeHeader(String heading) => Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    color: Colors.grey[350],
    child: Text(
      heading,
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20.0),
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
