import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {

        },
        itemCount: 10,
      ),
    );
  }
}