import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lhs_connections/models/feedPost.dart';
import 'package:lhs_connections/widgets/custom_widgets/basic_card.dart';

class FeedScreen extends StatefulWidget {
  List<feedPost> posts;

  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Feed')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('feed').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot)
  {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final post = feedPost.fromSnapshot(data);
    return ExpansionTile(
      leading: Text('From: ' + post.poster),
      title: Text(post.title + '  ' + post.postedOn),
      children: <Widget> [
        Text(post.body),
      ]
    );
    }
}

