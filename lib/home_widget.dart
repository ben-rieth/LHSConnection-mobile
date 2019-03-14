import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LHS Connection"),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.account_circle),
            title: Text("Account"),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.search),
            title: Text("Search"),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.question_answer),
            title: Text("Something"),
          ),
        ],
      ),
    );
  }
}
