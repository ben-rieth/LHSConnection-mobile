import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lhs_connections/models/User.dart';

class Club {

  DocumentReference reference;

  String name;
  String description;
  IconData icon;
  List<String> tags;
  String sponsor;

  List<User> clubMembers;


  Club({String name, String description, IconData icon, List<String> tags,
    this.sponsor});
      //: super(name: name, description: description, icon: icon, tags: tags);

  Club.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['description'] != null),
        assert(map['icon'] != null),
        assert(map['tags'] != null),

        name = map['name'],
        description = map['description'],
        icon = map['icon'],
        tags = map['tags'];

  Club.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}