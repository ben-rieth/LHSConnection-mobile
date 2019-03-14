import 'package:flutter/material.dart';

final items = List<String>.generate(10000, (i) => "Item $i");

class Search extends StatefulWidget {
  @override
  State<Search> createState() =>  _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController editingController = new TextEditingController();

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
                labelText: "Search",
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
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${items[index]}'),
                );
              },
            ),
          ),

        ],
      ),


      /*child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${items[index]}'),
          );
        },
      ),*/
    );
  }

  void _onSearchChange(String query) {

  }

}