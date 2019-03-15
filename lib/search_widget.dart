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
                items: <DropdownMenuItem<String>>[

                  DropdownMenuItem<String>(
                    value: "Any",
                    child: Text("Any"),
                  ),

                  DropdownMenuItem<String>(
                    value: "Classes",
                    child: Text("Classes"),
                  ),

                  DropdownMenuItem<String>(
                    value: "Clubs",
                    child: Text("Clubs"),
                  ),

                  DropdownMenuItem<String>(
                    value: "People",
                    child: Text("People"),
                  ),

                ],
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${_filteredItems[index]}'),
                );
              },
            ),
          ),

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
        _filteredItems.clear();
        _filteredItems.addAll(dummyListData);
      });

    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

}