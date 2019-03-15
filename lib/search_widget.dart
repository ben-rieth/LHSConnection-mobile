import 'package:flutter/material.dart';

final items = List<String>.generate(10000, (i) => "Item $i");

class Search extends StatefulWidget {
  @override
  State<Search> createState() =>  _SearchState();
}

class _SearchState extends State<Search> {
  List<String> _filteredItems = List<String>();
  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");

  TextEditingController editingController = new TextEditingController();

  @override
  void initState() {
    _filteredItems.addAll(duplicateItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container (
      child: Column (
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _onSearchChange,
              controller: editingController,
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
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