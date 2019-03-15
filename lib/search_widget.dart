import 'package:flutter/material.dart';

final items = List<String>.generate(10000, (i) => "Item $i");

class Search extends StatefulWidget {
  @override
  State<Search> createState() =>  _SearchState();
}

class _SearchState extends State<Search> {
  List<String> _filteredItems = List<String>();
  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  String dropdownValue = "Any";
  bool _resultsAreVisible = false;

  TextEditingController editingController = new TextEditingController();

  @override
  void initState() {
    _filteredItems.addAll(duplicateItems);
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

          _resultsAreVisible ? Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${_filteredItems[index]}'),

                );
              },
            ),
          ) : new Container(),

        ],
      ),
    );
  }

  void _newFilter(String newValue) {
    setState(() {
      dropdownValue = newValue;
    });
  }

  void _onSearchChange(String query) {
    _filterSearchResults(query);
  }

  void _filterSearchResults (String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);

    if(query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if(item.contains(query)) {
          dummyListData.add(item);
        }
      });

      setState(() {
        _resultsAreVisible = true;
        _filteredItems.clear();
        _filteredItems.addAll(dummyListData);
      });

    } else {
      setState(() {
        _resultsAreVisible = false;
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

}