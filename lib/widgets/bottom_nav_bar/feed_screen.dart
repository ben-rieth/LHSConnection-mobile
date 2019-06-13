import 'package:flutter/material.dart';
import 'package:lhs_connections/widgets/custom_widgets/basic_card.dart';

class FeedScreen extends StatefulWidget {
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0.0),
      child: new Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Feed",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Text('idrk anything'),
          floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
      ),
      ),
    );
  }
}


