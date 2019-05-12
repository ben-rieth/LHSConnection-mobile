
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Class  {

  DocumentReference reference;

  String name;
  String description;
  IconData icon;
  List<dynamic> tags;
  String numCredit;
  List<dynamic> gradeLevels;
  List<dynamic> requiredCourses;

  Class({this.name, this.description, this.icon, this.tags,
    this.numCredit, this.gradeLevels, this.requiredCourses});
  //: super(name: name, description: description, icon: icon, tags: tags);

  Class.fromMap(Map<String, dynamic> map, {this.reference})
      : //assert(map['name'] != null),
  //assert(map['bio'] != null),
  //assert(map['icon'] != null),
  //assert(map['tags'] != null),
  //assert(map['credits'] != null),
  //assert(map['grade'] != null),


        name = map['name'],
        description = map['bio'],
        icon = setIcon(map['icon']),
        tags = map['tags'],
        numCredit = map['credits'],
        gradeLevels = map['grades'],
        requiredCourses = map['req'];

  Class.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);


  @override
  String toString() {
    return "Class: name=${this.name} tags=${this.tags} credits=${this.numCredit}" +
        " gradeLevels=${this.gradeLevels} requiredCourses=${this.requiredCourses}";
  }

  static IconData setIcon(int classType) {
    switch(classType) {

      case 1:
        return FontAwesomeIcons.book;
        break;
      case 2:
        return FontAwesomeIcons.calculator;
        break;
      case 3:
        return FontAwesomeIcons.globeAmericas;
        break;
      case 4:
        return FontAwesomeIcons.microscope;
        break;
      case 5:
        return FontAwesomeIcons.dumbbell;
        break;
      case 6:
        return FontAwesomeIcons.language;
        break;
      case 7:
        return FontAwesomeIcons.school;
        break;


      case 8:
        return FontAwesomeIcons.music;
        break;
      case 9:
        return FontAwesomeIcons.theaterMasks;
        break;
      case 10:
        return FontAwesomeIcons.paintBrush;
        break;


      case 11:
        return FontAwesomeIcons.briefcase;
        break;
      case 12:
        return FontAwesomeIcons.laptopCode;
        break;
      case 13:
        return FontAwesomeIcons.car;
        break;
      case 14:
        return FontAwesomeIcons.tools;
        break;
      case 15:
        return FontAwesomeIcons.home;
        break;
      default:
        return Icons.not_interested;
        break;
    }
  }

}