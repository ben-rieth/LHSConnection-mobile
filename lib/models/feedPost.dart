import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class feedPost {
  DocumentReference reference;

  String title;
  String poster;
  String postedOn;
  String body;

  feedPost({this.title, this.poster, this.postedOn, this.body});

  feedPost.fromMap(Map<String, dynamic> map, {this.reference})
      : title = map['title'],
        poster = map['poster'],
        postedOn = map['postedOn'],
        body = map['body'];

  feedPost.fromSnapshot(DocumentSnapshot snap)
  : this.fromMap(snap.data, reference: snap.reference);
}
