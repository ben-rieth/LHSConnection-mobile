import 'package:flutter/material.dart';

class User {

  String name;
  String grade;
  Image profilePicture;

  String username;
  String password;

  User(this.name, this.grade, this.username, this.password);

  User.withImage(this.name, this.grade, this.profilePicture, this.username,
      this.password);
}