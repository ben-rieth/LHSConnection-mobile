import 'package:cloud_firestore/cloud_firestore.dart';

class User {

  DocumentReference reference;

  String id;
  String fName;
  String lName;
  String email;
  String gradeLevel;
  List<String> interests;

  User.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['email'] != null),
        assert(map['id'] != null),
        assert(map['gradeLevel'] != null),

        fName = map['fName'],
        lName = map['lName'],
        email = map['email'],
        id = map['uname'],
        gradeLevel = map['glvl'];

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}