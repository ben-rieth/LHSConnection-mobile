import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {

  final List<String> _extensionTileHeaders = ["Classes", "Clubs"];

  final List<String> _clubList = ["Robotics", "Marching Band", "Theater"];
  final List<String> _classList = ["Symponic Band", "AP Psychology",
    "AP Calculus AB", "AP Literature", "AP Physics 2", "IB Computer Science 2",
    "A+ Certification"];

  @override
  Widget build(BuildContext context) {

    FocusScope.of(context).requestFocus(new FocusNode());

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          children: <Widget>[

            Center(
              child: CircleAvatar(
                child: Text("Picture"),
                radius: 50.0,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Name Goes Here",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _extensionTileHeaders.length,
                itemBuilder: (BuildContext context, int index) {
                  return ExpansionTile(
                    title: Text(_extensionTileHeaders[index]),
                    children: _buildListViews(index),
                  );
                }

              ),
            ),

          ],
        ),
      ),
    );

  }

  List<Widget> _buildListViews(int index) {
    switch(index) {
      case 0: return _buildClassListView();
      case 1: return _buildClubListView();
      default: return <Widget>[];
    }
  }

  List<Widget> _buildClassListView() {
    return _classList.map<ListTile>((String className) {
      return ListTile(
        title: Text(className),
      );
    }).toList();
  }

  List<Widget> _buildClubListView() {
    return _clubList.map<ListTile>((String clubName) {
      return ListTile(
        title: Text(clubName),
      );
    }).toList();
  }



}