import 'package:cloud_firestore/cloud_firestore.dart';

class User {

  DocumentReference reference;

  String id;
  String name;
  String email;
  String gradeLevel;

  User.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['email'] != null),
        assert(map['id'] != null),
        assert(map['gradeLevel'] != null),

        name = map['name'],
        email = map['email'],
        id = map['id'],
        gradeLevel = map['gradeLevel'];

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}