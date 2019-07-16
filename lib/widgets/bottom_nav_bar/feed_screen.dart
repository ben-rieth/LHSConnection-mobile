import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Gamut/models/feedPost.dart';
import 'package:Gamut/models/user.dart';

TextEditingController _titleController = TextEditingController();
TextEditingController _contentController = TextEditingController();
final _formTitleKey = GlobalKey<FormState>();
final _formContentKey = GlobalKey<FormState>();
var postId = 0;

class FeedScreen extends StatefulWidget {

  final User user;
  FeedScreen({Key key, @required this.user}) : super(key: key);

  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Feed')),
      body: _buildBody(context),
      floatingActionButton: new FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return makePostDialog();
                });
          }),
    );
  }

  void post() {
    Firestore.instance.collection('feed').document().setData({
      'body': _contentController.text,
      'title': _titleController.text,
      'postedOn': DateTime.now().toString(),
      'poster': "${widget.user.fName} " +
    "${widget.user.lName}",
    });
  }

  AlertDialog makePostDialog() {
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
      titlePadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      title: TextFormField(
        controller: _titleController,
        key: _formTitleKey,
        maxLines: 1,
        style: TextStyle(
          fontSize: 18.0,
        ),
        decoration: InputDecoration(
          hintText: "Title",
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            controller: _contentController,
            key: _formContentKey,
            maxLines: 10,
            decoration: InputDecoration(
              hintText: " Content",
              hintStyle: TextStyle(
                fontSize: 14.0,
              ),
              contentPadding: EdgeInsets.all(10.0),
              border: OutlineInputBorder(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.grey[500],
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("Add"),
          onPressed: () {
            post();
            Navigator.of(context).pop();
          },
        ),
      ],
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

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
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
        children: <Widget>[
          Text(post.body),
        ]);
  }
}
