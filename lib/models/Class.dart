
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Class  {

  DocumentReference reference;

  String name;
  String description;
  IconData icon;
  List<dynamic> tags;
  String numCredit;
  List<dynamic> gradeLevels;
  String requiredCourses;

  Class({this.name, this.description, this.icon, this.tags,
    this.numCredit, this.gradeLevels, this.requiredCourses});
  //: super(name: name, description: description, icon: icon, tags: tags);

  Class.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        //assert(map['bio'] != null),
        //assert(map['icon'] != null),
        assert(map['tags'] != null),
        //assert(map['credits'] != null),
        //assert(map['grade'] != null),


        name = map['name'],
        description = map['bio'],
        //icon = map['icon'],
        tags = map['tags'],
        numCredit = map['credits'].toString(),
        gradeLevels = map['grade'],
        requiredCourses = map['requiredCourses'];

  Class.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

}