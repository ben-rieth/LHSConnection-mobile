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
      : assert(map['fname'] != null),
        assert(map['lname'] != null),
        assert(map['email'] != null),
        assert(map['glvl'] != null),

        fName = map['fname'],
        lName = map['lname'],
        email = map['email'],
        id = map['uname'],
        gradeLevel = gradeLevelToText(map['glvl']);

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  static String gradeLevelToText(String glvl) {
    switch(glvl) {
      case "9":
        return "Freshman";
        break;
      case "10":
        return "Sophomore";
        break;
      case "11":
        return "Junior";
        break;
      case "12":
        return "Senior";
        break;
    }

    return "Mistake";
  }
}