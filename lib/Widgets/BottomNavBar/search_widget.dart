import 'package:flutter/material.dart';

import 'package:lhs_connections/Models/Club.dart';
import 'package:lhs_connections/Models/DummyData/dummy_clubs.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() =>  _SearchState();
}

class _SearchState extends State<Search> {
  List<Club> clubs;
  List<Club> _filteredItems = List<Club>();
  String dropdownValue = "Any";
  bool _resultsAreVisible = false;

  TextEditingController editingController = new TextEditingController();

  @override
  void initState() {
    clubs = DummyClubs().dummyClubs;
    _filteredItems.addAll(clubs);
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
              onChanged:  _onSearchChange,
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

          _resultsAreVisible ? Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                return makeCard(_filteredItems[index]);
              },
            ),
          ) : new Container(),

        ],
      ),
    );
  }

  Card makeCard(Club club) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.lightGreen),

        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),

          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
              border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.blueGrey))),
            child: Icon(club.icon, color: Colors.blueGrey),
          ),

          title: Text(
              club.name,
              style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
          ),

          trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.blueGrey, size: 30.0),

        ),
      ),
  );


  void _newFilter(String newValue) {
    setState(() {
      dropdownValue = newValue;
    });
  }

  void _onSearchChange(String query) {
    query = query.toLowerCase();
    query = query.trim();

    if(query.length > 2) {
      _filterSearchResults(query);
    }
  }

  void _filterSearchResults (String query) {
    List<Club> dummySearchList = List<Club>();
    dummySearchList.addAll(clubs);



    if(query.isNotEmpty) {
      List<Club> dummyListData = List<Club>();
      dummySearchList.forEach((club) {

        String name = club.name.toLowerCase();

        if(name.contains(query)) {
          dummyListData.add(club);
        }

        club.tags.forEach((tag) {

          String currTag = tag.toLowerCase();

          if(currTag.contains(query)) {
            dummyListData.add(club);
          }
        });

      });

      setState(() {
        _resultsAreVisible = true;
        _filteredItems.clear();
        _filteredItems.addAll(dummyListData);
      });

    } else {
      setState(() {
        _resultsAreVisible = false;
        clubs.clear();
        clubs.addAll(dummySearchList);
      });
    }
  }


}