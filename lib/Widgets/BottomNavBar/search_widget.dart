import 'package:flutter/material.dart';

import 'package:lhs_connections/Models/Club.dart';
import 'package:lhs_connections/Models/Class.dart';
import 'package:lhs_connections/Models/Activity.dart';
import 'package:lhs_connections/Models/DummyData/dummy_clubs.dart';
import 'package:lhs_connections/Models/DummyData/dummy_classes.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() =>  _SearchState();
}

class _SearchState extends State<Search> {
  List<Activity> clubs;
  List<Activity> classes;

  List<Activity> _filteredClubs = List<Activity>();
  List<Activity> _filteredClasses = List<Activity>();

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
    return Container (
      //color: Colors.greenAccent,
      child: Column (
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.all(8.0),
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
              child: DropdownButton<String> (
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

          _resultsAreVisible && _areClassesVisible ? makeHeader("Classes")
              : new Container(),

          _resultsAreVisible && _areClassesVisible && _noClassesFound ?
              makeNothingFoundStatement("No classes found") : new Container(),

          _resultsAreVisible && _areClassesVisible && !_noClassesFound ?
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredClasses.length,
                itemBuilder: (context, index) {
                  return makeCard(_filteredClasses[index]);
                },
              ),
            ) : new Container(),

          _resultsAreVisible && _areClubsVisible ? makeHeader("Clubs")
              : new Container(),

          _resultsAreVisible && _areClassesVisible && _noClubsFound ?
          makeNothingFoundStatement("No clubs found") : new Container(),

          _resultsAreVisible && _areClubsVisible && !_noClubsFound ?
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredClubs.length,
                itemBuilder: (context, index) {
                  return makeCard(_filteredClubs[index]);
                },
              ),
            ) : new Container(),

        ],
      ),
    );
  }

  Card makeCard(Activity act) {

    String tagSubtitle = "";

    act.tags.forEach((tag) {
      tagSubtitle += "$tag, ";
    });

    tagSubtitle = tagSubtitle.trim();
    tagSubtitle = tagSubtitle.substring(0, tagSubtitle.length-2);

    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.lightGreen),

        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: 20.0, vertical: 10.0),

          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.blueGrey))),
            child: Icon(act.icon, color: Colors.blueGrey),
          ),

          title: Text(
            act.name,
            style: TextStyle(
                color: Colors.blueGrey, fontWeight: FontWeight.bold),
          ),

          subtitle: Text(
              tagSubtitle,
              style: TextStyle(color: Colors.blueGrey),
          ),

          trailing:
          Icon(Icons.keyboard_arrow_right, color: Colors.blueGrey, size: 30.0),

        ),
      ),
    );
  }


  void _newFilter(String newValue) {
    setState(() {
      dropdownValue = newValue;

      if(newValue == "Classes") {
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

  void _searchSort (String query) {
    if(_areClubsVisible && _areClassesVisible) {
      _filterSearchResults(query, clubs);
      _filterSearchResults(query, classes);
    }

    else if(_areClassesVisible && !_areClubsVisible)
      _filterSearchResults(query, classes);

    else if(!_areClassesVisible && _areClubsVisible)
      _filterSearchResults(query, clubs);

  }


  void _filterSearchResults (String query, List<Activity> currList) {
    List<Activity> dummySearchList = List<Activity>();
    dummySearchList.addAll(currList);

    if(query.isNotEmpty) {
      List<Activity> dummyListData = List<Activity>();
      dummySearchList.forEach((activity) {

        String name = activity.name.toLowerCase();

        if(name.contains(query)) {
          dummyListData.add(activity);
        }

        activity.tags.forEach((tag) {

          String currTag = tag.toLowerCase();

          if(currTag.contains(query)) {
            dummyListData.add(activity);
          }
        });

      });

      setState(() {
        _resultsAreVisible = true;
        if(dummyListData.length == 0) {
          if (dummySearchList[0] is Class) {
            _noClassesFound = true;
          } else if (dummySearchList[0] is Club) {
            _noClubsFound = true;
          }
        } else {
          if (dummyListData[0] is Class) {
            _noClassesFound = false;

            _filteredClasses.clear();
            _filteredClasses.addAll(dummyListData);
          } else if (dummyListData[0] is Club) {
            _noClubsFound = false;

            _filteredClubs.clear();
            _filteredClubs.addAll(dummyListData);
          }

        }
      });

    } else {
      setState(() {
        _resultsAreVisible = false;
      });
    }
  }

  Center makeHeader(String heading) => Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        heading,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20.0),
      ),
    ),
  );

  Center makeNothingFoundStatement(String heading) => Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        "No clubs found",
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w300,
            fontSize: 20.0),
      ),
    ),
  );
}