import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {

  final TextEditingController searchController;
  final ValueChanged<String> onSearchChange;

  SearchBar({this.searchController, this.onSearchChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
      child: TextField(
        autofocus: true,
        onSubmitted: onSearchChange,
        controller: searchController,
        style: TextStyle(
          fontSize: 20.0,
          //height: .5,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(11.0),
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          hintText: "Search",
          prefixIcon: Icon(Icons.search, size: 25.0, color: Colors.grey[600],),
          //border: OutlineInputBorder(
          //    borderRadius: BorderRadius.all(Radius.circular(25.0))),
        ),
      ),
    );
  }

}