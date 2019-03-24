import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

User userFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromJson(jsonData);
}

String userToJson(User data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class User {
  String uid;
  String name;
  String email;
  String gradeLevel;

  User({
    this.uid,
    this.name,
    this.email
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
    uid: json["userId"],
    name: json["name"],
    email: json["email"],
    //gradeLevel: json["gradeLevel"],
  );

  Map<String, dynamic> toJson() => {
    "userId": uid,
    "name": name,
    "email": email,
    //"gradeLevel": gradeLevel,
  };

  factory User.fromDocument(DocumentSnapshot doc) {
    return User.fromJson(doc.data);
  }
}