import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Class  {

  DocumentReference reference;

  String name;
  String description;
  IconData icon;
  List<String> tags;
  double numCredit;
  List<int> gradeLevels;
  List<String> requiredCourses;

  Class({this.name, this.description, this.icon, this.tags,
    this.numCredit, this.gradeLevels, this.requiredCourses});
  //: super(name: name, description: description, icon: icon, tags: tags);

  Class.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['description'] != null),
        assert(map['icon'] != null),
        assert(map['tags'] != null),
        assert(map['numCredit'] != null),
        assert(map['gradeLevels'] != null),
        assert(map['requiredCourses'] != null),

        name = map['name'],
        description = map['description'],
        icon = map['icon'],
        tags = map['tags'],
        numCredit = map['numCredit'],
        gradeLevels = map['gradeLevels'],
        requiredCourses = map['requiredCourses'];

  Class.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

}
